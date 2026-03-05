return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  config = function()
    require("competitest").setup({
      -- Always default to C++ — skips the language popup entirely
      default_language = "cpp",

      -- Competitive Companion browser extension port (must match extension settings)
      companion_port = 27121,

      -- Don't prompt for path/directory/extension when receiving
      received_problems_prompt_path = false,
      received_contests_prompt_directory = false,
      received_contests_prompt_extension = false,

      -- Where received problems and contests are saved
      -- $(CWD) = current working directory, $(PROBLEM) = problem name
      received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)",
      received_contests_directory = "$(CWD)/$(JUDGE)/$(CONTEST)",
      received_contests_problems_path = "$(PROBLEM).$(FEXT)",
      received_files_extension = "cpp",

      -- Open file automatically after receiving
      open_received_problems = true,
      open_received_contests = true,

      -- Replace testcases if problem is re-parsed
      replace_received_testcases = true,

      -- Empty string = use the file's own directory for compile/run
      compile_directory = "",
      running_directory = "",

      -- C++ compile and run commands
      -- Binary goes to compitest/bins/ relative to the source file's directory
      -- Uses sh -c to mkdir first since g++ can't create directories
      compile_command = {
        cpp = {
          exec = "sh",
          args = { "-c", "mkdir -p compitest/bins && g++ -std=c++17 -O2 -Wall -Wextra -DLOCAL '$(FNAME)' -o 'compitest/bins/$(FNOEXT)'" },
        },
      },
      run_command = {
        cpp = { exec = "compitest/bins/$(FNOEXT)" },
      },

      -- Run all testcases at once; 5 second timeout
      multiple_testing = -1,
      maximum_time = 5000,

      -- Be lenient with trailing whitespace/newlines when comparing output
      output_compare_method = "squish",
      view_output_diff = true,

      -- Testcase files in compitest/tc/ relative to the source file's directory
      testcases_directory = "compitest/tc",
      testcases_use_single_file = false,
      testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
      testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",

      -- Popup UI for runner
      runner_ui = {
        interface = "popup",
      },

      -- Template for newly created files from received problems
      template_file = {
        cpp = "~/.config/nvim/templates/cp.cpp",
      },
      evaluate_template_modifiers = true,
    })

    -- Keymaps (prefix: <leader>c for competitive programming)
    -- <leader>cl starts listening — parse any number of problems in the browser and they all arrive automatically
    vim.keymap.set("n", "<leader>cl", "<cmd>CompetiTest receive contest<CR>", { desc = "CTest: Listen for Problems" })
    vim.keymap.set("n", "<leader>cr", "<cmd>w | CompetiTest run<CR>", { desc = "CTest: Save & Run All Testcases" })
    vim.keymap.set("n", "<leader>ca", "<cmd>CompetiTest add_testcase<CR>", { desc = "CTest: Add Testcase" })
    vim.keymap.set("n", "<leader>ce", "<cmd>CompetiTest edit_testcase<CR>", { desc = "CTest: Edit Testcase" })
    vim.keymap.set("n", "<leader>cd", "<cmd>CompetiTest delete_tcs<CR>", { desc = "CTest: Delete Testcases" })

    -- Submit to Codeforces via cph-submit browser extension
    -- Writes payload to a temp file, then a Python server reads it and serves it.
    -- The cph-submit extension polls localhost:27121/getSubmit every 3s and auto-submits.
    vim.keymap.set("n", "<leader>cs", function()
      vim.cmd("w") -- save first

      -- Extract URL from first 5 lines (template puts "// URL: ..." at top)
      local lines = vim.api.nvim_buf_get_lines(0, 0, 5, false)
      local url = nil
      for _, line in ipairs(lines) do
        local match = line:match("^// URL: (https?://[%S]+)")
        if match then
          url = match
          break
        end
      end
      if not url then
        vim.notify("No URL found! Expected '// URL: ...' in first 5 lines.", vim.log.levels.ERROR)
        return
      end

      -- Get problem name from filename
      local problem_name = vim.fn.expand("%:t:r")

      -- Read entire file as source code
      local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local source_code = table.concat(all_lines, "\n")

      -- Language ID 54 = GNU G++17 7.3.0 on Codeforces
      local language_id = 54

      -- JSON payload for cph-submit
      local payload = vim.fn.json_encode({
        empty = false,
        url = url,
        problemName = problem_name,
        sourceCode = source_code,
        languageId = language_id,
      })

      -- Write payload to a temp file (avoids all escaping issues)
      local tmpfile = os.tmpname()
      local f = io.open(tmpfile, "w")
      if not f then
        vim.notify("Failed to create temp file for submit payload", vim.log.levels.ERROR)
        return
      end
      f:write(payload)
      f:close()

      -- Write the server script to a temp file too (avoids -c quoting issues)
      local script_file = os.tmpname() .. ".py"
      local sf = io.open(script_file, "w")
      sf:write([[
import http.server, json, sys, os, threading

payload_file = sys.argv[1]
script_file = sys.argv[2]
with open(payload_file, "r") as f:
    payload = f.read()
os.unlink(payload_file)
os.unlink(script_file)

empty = json.dumps({"empty": True})
served = False

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        global served
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Headers", "cph-submit")
        self.end_headers()
        if not served and self.path == "/getSubmit":
            self.wfile.write(payload.encode())
            served = True
            threading.Timer(6, lambda: server.shutdown()).start()
        else:
            self.wfile.write(empty.encode())
    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Headers", "cph-submit")
        self.send_header("Access-Control-Allow-Methods", "GET, OPTIONS")
        self.end_headers()
    def log_message(self, format, *args):
        pass

try:
    server = http.server.HTTPServer(("127.0.0.1", 27121), Handler)
    server.serve_forever()
except OSError:
    sys.exit(1)
]])
      sf:close()

      -- Launch fully detached from Neovim (nohup + & + redirects)
      -- This ensures the server isn't tied to Neovim's I/O at all
      os.execute(string.format(
        "nohup python3 '%s' '%s' '%s' >/dev/null 2>&1 &",
        script_file, tmpfile, script_file
      ))
      vim.notify("Submitting... cph-submit will pick it up in ~3s", vim.log.levels.INFO)
    end, { desc = "CTest: Submit via cph-submit" })


    -- When a new cpp file is opened from a template, place cursor inside while loop
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "*.cpp",
      callback = function()
        -- Only act on fresh files (unmodified, likely just created from template)
        if not vim.bo.modified then
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          for i, line in ipairs(lines) do
            if line:match("while%(_%-%-%){") then
              -- Place cursor on the next line (empty line inside the loop), col 9
              vim.api.nvim_win_set_cursor(0, { i + 1, 8 })
              vim.cmd("startinsert")
              return
            end
          end
        end
      end,
      once = true,
    })
  end,
}
