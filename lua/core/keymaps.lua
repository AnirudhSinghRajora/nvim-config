-- Core Editor Keymaps

-- Oil file manager
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory in Oil" })

-- Jump between markdown headers (scoped to markdown files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(event)
    vim.keymap.set("n", "gj", [[/^##\+ .*<CR>]], { buffer = event.buf, silent = true, desc = "Next markdown header" })
    vim.keymap.set("n", "gk", [[?^##\+ .*<CR>]], { buffer = event.buf, silent = true, desc = "Prev markdown header" })
  end,
})

-- Exit insert mode without hitting Esc
vim.keymap.set("i", "jj", "<Esc>", { desc = "Quick Esc" })

-- Select all buffer text
vim.keymap.set("n", "==", "gg<S-v>G", { desc = "Select entire buffer" })

-- Keep cursor centered during scrolling and navigation
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below preserving cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search match centered" })

-- Paste over visual selection without clobbering paste register
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without overwriting register" })

-- Copy text to system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank into system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank into system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line into system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Delete text into black hole register (moved to <leader>D so <leader>d is purely DAP prefix)
vim.keymap.set("n", "<leader>D", '"_d', { desc = "Delete into black hole register" })
vim.keymap.set("v", "<leader>D", '"_d', { desc = "Delete into black hole register" })

-- Disable accidental Ex-mode entry
vim.keymap.set("n", "Q", "<nop>")

-- Buffer closing
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>w", "<cmd>bp|bd #<CR>", { desc = "Close Buffer; Retain Split" })

-- Quickfix list navigation (centered)
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix item" })

-- Location list navigation (centered)
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz", { desc = "Prev location list item" })

-- Replace word under cursor across entire buffer (moved to <leader>sr to avoid <leader>sp/<leader>sP stall)
vim.keymap.set(
  "n",
  "<leader>sr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)

-- Make current file executable (in-process via libuv without spawning a shell)
vim.keymap.set("n", "<leader>x", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file ~= "" then
    local uv = vim.uv or vim.loop
    uv.fs_chmod(file, tonumber("755", 8))
    vim.notify("Marked executable: " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
  end
end, { desc = "Make current file executable" })

-- Jump to plugin configuration files (dynamic stdpath)
vim.keymap.set("n", "<leader>vpp", function()
  vim.cmd.edit(vim.fn.stdpath("config") .. "/lua/plugins")
end, { desc = "Open plugins directory" })

-- Test Runner (Neotest)
vim.keymap.set("n", "<leader>tr", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run Nearest Test" })
vim.keymap.set(
  "n",
  "<leader>tf",
  "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  { desc = "Run Current Test File" }
)
vim.keymap.set(
  "n",
  "<leader>td",
  "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<CR>",
  { desc = "Run Current Test Directory" }
)
vim.keymap.set(
  "n",
  "<leader>tp",
  "<cmd>lua require('neotest').output_panel.toggle()<CR>",
  { desc = "Toggle Test Output Panel" }
)
vim.keymap.set("n", "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", { desc = "Run Last Test" })
vim.keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "Toggle Test Summary" })

-- DAP Debugging
vim.keymap.set("n", "<leader>dt", "<cmd>DapContinue<CR>", { desc = "Start / Continue Debugging" })
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Start / Continue Debugging" })
vim.keymap.set("n", "<leader>dso", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<leader>dsi", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<leader>dsu", "<cmd>DapStepOut<CR>", { desc = "Step Out" })
vim.keymap.set("n", "<leader>dst", "<cmd>DapTerminate<CR>", { desc = "Terminate Debugger" })
vim.keymap.set("n", "<leader>b", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
vim.keymap.set(
  "n",
  "<leader>B",
  "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Conditional Breakpoint" }
)
vim.keymap.set(
  "n",
  "<leader>E",
  "<cmd>lua require('dap').set_exception_breakpoints()<CR>",
  { desc = "Exception Breakpoints" }
)
vim.keymap.set(
  "n",
  "<leader>dr",
  "<cmd>lua require('dapui').float_element('repl', { width = 100, height = 40, enter = true })<CR>",
  { desc = "Show DAP REPL" }
)
vim.keymap.set(
  "n",
  "<leader>dsc",
  "<cmd>lua require('dapui').float_element('scopes', { width = 150, height = 50, enter = true })<CR>",
  { desc = "Show DAP Scopes" }
)
vim.keymap.set(
  "n",
  "<leader>df",
  "<cmd>lua require('dapui').float_element('stacks', { width = 150, height = 50, enter = true })<CR>",
  { desc = "Show DAP Stacks" }
)
vim.keymap.set(
  "n",
  "<leader>db",
  "<cmd>lua require('dapui').float_element('breakpoints', { enter = true })<CR>",
  { desc = "Show DAP Breakpoints" }
)
vim.keymap.set("n", "<leader>do", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", { desc = "Debug Last Test" })

-- Copy file paths
vim.keymap.set("n", "<leader>cf", "<cmd>let @+ = expand('%')<CR>", { desc = "Copy File Name" })
vim.keymap.set("n", "<leader>cp", "<cmd>let @+ = expand('%:p')<CR>", { desc = "Copy File Path" })

-- Source current file
vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>", { desc = "Source current file" })

-- Dismiss notifications & clear search highlights with Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><cmd>Noice dismiss<CR>", { desc = "Clear highlights & dismiss notifications" })

-- Notification management
vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<CR>", { desc = "Dismiss active notifications" })
vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "Show notification history" })

-- Open Zoxide directory jumper
vim.keymap.set("n", "<leader>Z", "<cmd>Zi<CR>", { desc = "Open Zoxide Picker" })

-- Window split resizing
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize +2<CR>", { desc = "Resize Horizontal Split Taller" })
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize -2<CR>", { desc = "Resize Horizontal Split Shorter" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize Vertical Split Narrower" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize Vertical Split Wider" })

-- Obsidian keymaps
vim.keymap.set("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>", { desc = "Toggle Checkbox" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Template" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show Backlinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show Links" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New Note" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Notes" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch Note" })

-- Visual Mode Helpers
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Line start/end motions
vim.keymap.set({ "n", "o", "x" }, "<s-h>", "^", { desc = "Jump to beginning of line" })
vim.keymap.set({ "n", "o", "x" }, "<s-l>", "g_", { desc = "Jump to end of line" })

-- Move line / block (VSCode style)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Block Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Block Up" })
vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<CR>==", { desc = "Move Line Down" })
vim.keymap.set("n", "<A-Up>", "<cmd>m .-2<CR>==", { desc = "Move Line Up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Block Down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Block Up" })
vim.keymap.set("i", "<A-Down>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move Line Down (insert)" })
vim.keymap.set("i", "<A-Up>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move Line Up (insert)" })

-- Duplicate line / selection (VSCode style)
vim.keymap.set("n", "<A-S-Down>", "<cmd>t .<CR>", { desc = "Duplicate Line Down" })
vim.keymap.set("n", "<A-S-Up>", "<cmd>t .-1<CR>", { desc = "Duplicate Line Up" })
vim.keymap.set("v", "<A-S-Down>", ":t '><CR>gv", { desc = "Duplicate Selection Down" })
vim.keymap.set("v", "<A-S-Up>", ":t '<-1<CR>gv", { desc = "Duplicate Selection Up" })
vim.keymap.set("i", "<A-S-Down>", "<Esc><cmd>t .<CR>gi", { desc = "Duplicate Line Down (insert)" })
vim.keymap.set("i", "<A-S-Up>", "<Esc><cmd>t .-1<CR>gi", { desc = "Duplicate Line Up (insert)" })

-- Search for highlighted text in buffer
vim.keymap.set("v", "//", 'y/<C-R>"<CR>', { desc = "Search for highlighted text" })

-- Terminal navigation & modes
vim.keymap.set("t", "<C-t>", "<C-\\><C-n>", { desc = "Exit terminal mode to normal" })
vim.keymap.set("n", "<C-b>", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>ci", "<cmd>vsplit input.txt<CR>", { desc = "Open input.txt split" })

-- Autocommands
local custom_buffer = vim.api.nvim_create_augroup("custom_buffer", { clear = true })

-- Auto enter insert mode when opening an interactive terminal (skip background tool panels)
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Auto enter insert mode when opening a terminal",
  group = custom_buffer,
  pattern = "*",
  callback = function(event)
    vim.defer_fn(function()
      if vim.api.nvim_buf_is_valid(event.buf) and vim.bo[event.buf].buftype == "terminal" then
        local ft = vim.bo[event.buf].filetype
        if (ft == "" or ft == "floaterm") and vim.api.nvim_get_current_buf() == event.buf then
          vim.cmd("startinsert")
        end
      end
    end, 100)
  end,
})

-- Highlight on yank (compatible with all Neovim versions)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = custom_buffer,
  pattern = "*",
  callback = function()
    local hl = vim.hl or vim.highlight
    hl.on_yank({ timeout = 200 })
  end,
})
