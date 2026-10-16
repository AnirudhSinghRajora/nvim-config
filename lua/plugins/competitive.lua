return {
  -- QuickRun
  {
    "thinca/vim-quickrun",
    cmd = "QuickRun",
    keys = {
      { "<leader>r", ":QuickRun -input input.txt<CR>", desc = "QuickRun with input.txt" },
    },
  },

  -- CompetiTest & Competitive Programming Tooling
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("competitest").setup({
        default_language = "cpp",
        companion_port = 27121,

        received_problems_prompt_path = false,
        received_contests_prompt_directory = false,
        received_contests_prompt_extension = false,

        received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)",
        received_contests_directory = "$(CWD)/$(JUDGE)/$(CONTEST)",
        received_contests_problems_path = "$(PROBLEM).$(FEXT)",
        received_files_extension = "cpp",

        open_received_problems = true,
        open_received_contests = true,
        replace_received_testcases = true,

        compile_directory = "",
        running_directory = "",

        compile_command = {
          cpp = {
            exec = "sh",
            args = { "-c", 'mkdir -p compitest/bins && g++ -std=c++17 -O2 -Wall -Wextra -DLOCAL "$(FNAME)" -o "compitest/bins/$(FNOEXT)"' },
          },
        },
        run_command = {
          cpp = {
            exec = "./compitest/bins/$(FNOEXT)",
            args = {},
          },
        },

        multiple_testing = -1,
        maximum_time = 5000,
        output_compare_method = "squish",
        view_output_diff = true,

        testcases_directory = "compitest/tc",
        testcases_use_single_file = false,
        testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
        testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",

        runner_ui = {
          interface = "popup",
        },

        template_file = {
          cpp = vim.fn.stdpath("config") .. "/templates/cp.cpp",
        },
        evaluate_template_modifiers = true,
      })

      -- Automatically expand bc+ snippet and focus inside solve() when a new problem is opened
      local function expand_cp_snippet(buf)
        local ok, ls = pcall(require, "luasnip")
        if not ok then
          return
        end

        -- Synchronously load user snippets from lua/Snippets/ so first-run expansion never races
        pcall(function()
          require("luasnip.loaders.from_lua").load({
            paths = { vim.fn.stdpath("config") .. "/lua/Snippets/" },
          })
        end)

        local snips = ls.get_snippets("cpp") or {}
        local target_snip = nil
        for _, snip in ipairs(snips) do
          if snip.trigger == "bc+" or snip.name == "bc+" then
            target_snip = snip
            break
          end
        end

        if not target_snip then
          return
        end

        -- Double-check buffer hasn't already been expanded (must be <= 3 lines)
        local line_count = vim.api.nvim_buf_line_count(buf)
        if line_count > 3 then
          return
        end

        vim.api.nvim_win_set_cursor(0, { math.min(2, line_count), 0 })

        -- Expand snippet
        ls.snip_expand(target_snip)

        -- Position cursor at placeholder 1 (inside solve()) and enter Insert mode cleanly
        local current_node = ls.session.current_nodes[buf]
        if current_node and current_node.mark then
          local pos = current_node.mark:pos_begin()
          vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
        end

        -- Unlink the template session immediately so Tab never jumps out to the end of file
        pcall(function()
          ls.unlink_current()
        end)

        vim.cmd("startinsert")
      end

      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = vim.api.nvim_create_augroup("CompetiTestAutoSnippet", { clear = true }),
        pattern = "*.cpp",
        callback = function(args)
          -- Guard: Only expand once per buffer lifetime
          if vim.b[args.buf].cp_snippet_done then
            return
          end

          local line_count = vim.api.nvim_buf_line_count(args.buf)
          if line_count > 3 then
            return
          end

          local header = vim.api.nvim_buf_get_lines(args.buf, 0, 2, false)
          if #header == 0 or not header[1]:match("^// URL:") then
            return
          end

          -- Lock buffer immediately so duplicate events cannot run
          vim.b[args.buf].cp_snippet_done = true

          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf) and vim.api.nvim_get_current_buf() == args.buf then
              expand_cp_snippet(args.buf)
            end
          end)
        end,
      })

      -- Keymaps (using <leader>ct* for testcase management so <leader>ca and <leader>cd stay dedicated to LSP)
      vim.keymap.set("n", "<leader>cl", "<cmd>CompetiTest receive contest<CR>", { desc = "CTest: Listen for Problems" })
      vim.keymap.set("n", "<leader>cr", "<cmd>w | CompetiTest run<CR>", { desc = "CTest: Save & Run All Testcases" })
      vim.keymap.set("n", "<leader>cta", "<cmd>CompetiTest add_testcase<CR>", { desc = "CTest: Add Testcase" })
      vim.keymap.set("n", "<leader>cte", "<cmd>CompetiTest edit_testcase<CR>", { desc = "CTest: Edit Testcase" })
      vim.keymap.set("n", "<leader>ctd", "<cmd>CompetiTest delete_tcs<CR>", { desc = "CTest: Delete Testcases" })

      -- Submit to Codeforces via cph-submit browser extension
      vim.keymap.set("n", "<leader>cs", function()
        vim.cmd("w")

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

        if url:match("leetcode%.com") then
          vim.notify("LeetCode submit is not supported yet", vim.log.levels.WARN)
          return
        end

        url = url:gsub("codeforces%.com/problemset/problem/(%d+)/(%w+)", "codeforces.com/contest/%1/problem/%2")
        local problem_name = vim.fn.expand("%:t:r")
        local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local source_code = table.concat(all_lines, "\n")
        local language_id = vim.g.cph_language_id or 91

        local payload = vim.fn.json_encode({
          empty = false,
          url = url,
          problemName = problem_name,
          sourceCode = source_code,
          languageId = language_id,
        })

        local tmpfile = os.tmpname()
        local f = io.open(tmpfile, "w")
        if not f then
          vim.notify("Failed to create temp file for submit payload", vim.log.levels.ERROR)
          return
        end
        f:write(payload)
        f:close()

        -- Use os.tmpname() directly without appending ".py" so no orphan file is leaked in /tmp
        local script_file = os.tmpname()
        local sf = io.open(script_file, "w")
        if not sf then
          os.remove(tmpfile)
          vim.notify("Failed to create temp script for submit server", vim.log.levels.ERROR)
          return
        end
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

        vim.fn.jobstart({ "python3", script_file, tmpfile, script_file }, { detach = true })
        vim.notify("Submitting... cph-submit will pick it up in ~3s", vim.log.levels.INFO)
      end, { desc = "CTest: Submit via cph-submit" })

      -- LeetCode problem receiver
      local function handle_leetcode_problem(task)
        local cwd = vim.fn.getcwd()
        local problem_name = task.name or "unknown"
        local url = task.url or ""
        local parsed_code = task.parsedCode or ""
        local tests = task.tests or {}

        local dir = cwd .. "/LeetCode"
        vim.fn.mkdir(dir, "p")
        local filepath = dir .. "/" .. problem_name .. ".cpp"
        local content = "// URL: " .. url .. "\n" .. parsed_code

        local f = io.open(filepath, "w")
        if not f then
          vim.notify("Failed to create file: " .. filepath, vim.log.levels.ERROR)
          return
        end
        f:write(content)
        f:close()

        local tc_dir = dir .. "/compitest/tc"
        vim.fn.mkdir(tc_dir, "p")
        for i, test in ipairs(tests) do
          local input_path = tc_dir .. "/" .. problem_name .. "_input" .. (i - 1) .. ".txt"
          local output_path = tc_dir .. "/" .. problem_name .. "_output" .. (i - 1) .. ".txt"
          local inf = io.open(input_path, "w")
          if inf then inf:write(test.input or ""); inf:close() end
          local outf = io.open(output_path, "w")
          if outf then outf:write(test.output or ""); outf:close() end
        end

        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        vim.notify("LeetCode: " .. problem_name .. " received! (" .. #tests .. " test cases)", vim.log.levels.INFO)
      end

      vim.keymap.set("n", "<leader>lc", function()
        pcall(function() vim.cmd("CompetiTest receive stop") end)

        local uv = vim.uv or vim.loop
        if _G.lc_server and not _G.lc_server:is_closing() then
          _G.lc_server:close()
        end
        _G.lc_server = uv.new_tcp()
        local server = _G.lc_server

        local ok = pcall(function() server:bind("127.0.0.1", 27121) end)
        if not ok then
          vim.notify("Port 27121 busy — stop CompetiTest listen first", vim.log.levels.ERROR)
          return
        end

        server:listen(16, function(listen_err)
          if listen_err then
            vim.schedule(function()
              vim.notify("LeetCode listen error: " .. tostring(listen_err), vim.log.levels.ERROR)
            end)
            return
          end

          local client = uv.new_tcp()
          server:accept(client)

          local raw = ""
          client:read_start(function(_, chunk)
            if chunk then
              raw = raw .. chunk
              local header_end = raw:find("\r\n\r\n")
              if header_end then
                local headers = raw:sub(1, header_end - 1)
                local body = raw:sub(header_end + 4)

                -- Respond to browser CORS preflight OPTIONS requests without closing server
                if headers:match("^OPTIONS ") then
                  client:read_stop()
                  local cors_resp = table.concat({
                    "HTTP/1.1 204 No Content",
                    "Access-Control-Allow-Origin: *",
                    "Access-Control-Allow-Methods: POST, GET, OPTIONS",
                    "Access-Control-Allow-Headers: Content-Type",
                    "Content-Length: 0",
                    "Connection: close",
                    "\r\n",
                  }, "\r\n")
                  client:write(cors_resp, function()
                    if not client:is_closing() then client:close() end
                  end)
                  return
                end

                local content_length = tonumber(headers:match("[Cc]ontent%-[Ll]ength:%s*(%d+)"))
                if content_length and #body >= content_length then
                  client:read_stop()
                  local resp = table.concat({
                    "HTTP/1.1 200 OK",
                    "Access-Control-Allow-Origin: *",
                    "Content-Length: 0",
                    "Connection: close",
                    "\r\n",
                  }, "\r\n")
                  client:write(resp, function()
                    if not client:is_closing() then client:close() end
                  end)
                  if not server:is_closing() then server:close() end

                  local json_str = body:sub(1, content_length)
                  vim.schedule(function()
                    local decode_ok, task = pcall(vim.fn.json_decode, json_str)
                    if decode_ok and task then
                      handle_leetcode_problem(task)
                    else
                      vim.notify("Failed to parse LeetCode payload", vim.log.levels.ERROR)
                    end
                  end)
                end
              end
            else
              if not client:is_closing() then client:close() end
            end
          end)
        end)

        vim.notify("Listening for LeetCode problem on port 27121...", vim.log.levels.INFO)
      end, { desc = "LeetCode: Listen for Problem" })
    end,
  },
}
