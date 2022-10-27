local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local mappings = {
  v = {
    ["<"] = { "<gv", "Outdent keeping visual selection" },
    [">"] = { ">gv", "Indent keeping visual selection" },
    p = { '"_dP', "Paste without cutting" },
  },
  x = {
    J = { ":move '>+1<CR>gv-gv", "Move selected line down" },
    K = { ":move '<-2<CR>gv-gv", "Move selected line up" },
  },
  n = {
    ["<C-Up>"] = { ":resize +2<CR>", "Increase size of horizontal split" },
    ["<C-Down>"] = { ":resize -2<CR>", "Decrease size of horizontal split" },
    ["<C-Left>"] = { ":vertical resize +2<CR>", "Increase size of vertical split" },
    ["<C-Right>"] = { ":vertical resize -2<CR>", "Decrease size of vertical split" },
    ["<Tab>"] = { ":bnext<CR>", "Next Tab" },
    ["<S-Tab>"] = { ":bprevious<CR>", "Previous Tab" },
    j = { "gj", "Move cursor down visually" },
    k = { "gk", "Move cursor up visually" },
    ["gj"] = { "j", "Move cursor down" },
    ["gk"] = { "k", "Move cursor up" },

    ["gd"] = { ":lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
    ["gD"] = { ":lua vim.lsp.buf.declaration()<CR>", "Go to Declaration" },
    ["K"] = { ":lua vim.lsp.buf.hover()<CR>", "Hover" },
    ["gi"] = { ":lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
    ["gr"] = { ":Telescope lsp_references<CR>", "Find References" },
    ["gl"] = { ":lua vim.diagnostic.open_float()<CR>", "Show Diagnostics" },
    ["[d"] = { ":lua vim.diagnostic.goto_prev()<CR>", "Go to Next Diagnostic" },
    ["]d"] = { ":lua vim.diagnostic.goto_next()<CR>", "Go to Previous Diagnostic" },

    ["<leader>a"] = { ":Alpha<CR>", "Alpha" },
    ["<leader>b"] = { ":Telescope buffers<CR>", "Buffers" },
    ["<leader>c"] = { ":Bdelete<CR>", "Close Buffer" },
    ["<leader>e"] = { ":NvimTreeToggle<CR>", "Explorer" },
    ["<leader>f"] = { ":Telescope find_files hidden=true<CR>", "Find Files" },
    ["<leader>F"] = { ":Telescope live_grep<CR>", "Find Text" },
    ["<leader>P"] = { ":Telescope projects<CR>", "Projects" },
    ["<leader>q"] = { ":q<CR>", "Quit" },
    ["<leader>w"] = { ":w!<CR>", "Save" },
  },
}

local leaderMappings = {
  g = {
    b = { ":Telescope git_branches<CR>", "Checkout Branch" },
    B = { ":Gitsigns blame_line<CR>", "Blame" },
    c = { ":Telescope git_commits<CR>", "Checkout Commit" },
    d = { ":Gitsigns diffthis HEAD<CR>", "Diff" },
    g = { ":lua _TOGGLE_CLI('lazygit')<CR>", "Lazygit" },
    j = { ":Gitsigns next_hunk<CR>", "Next Hunk" },
    k = { ":Gitsigns prev_hunk<CR>", "Prev Hunk" },
    o = { ":Telescope git_status<CR>", "Open Changed File" },
    p = { ":Gitsigns preview_hunk<CR>", "Preview Hunk" },
    r = { ":Gitsigns reset_hunk<CR>", "Reset Hunk" },
    R = { ":Gitsigns reset_buffer<CR>", "Reset Buffer" },
    s = { ":Gitsigns stage_hunk<CR>", "Stage Hunk" },
    u = { ":Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },
  },
  h = {
    c = { ":Telescope commands<CR>", "Commands" },
    h = { ":Telescope help_tags<CR>", "Find Help" },
    m = { ":Telescope man_pages<CR>", "Man Pages" },
    r = { ":Telescope oldfiles<CR>", "Open Recent File" },
    R = { ":Telescope registers<CR>", "Registers" },
    k = { ":Telescope keymaps<CR>", "Keymaps" },
    t = {
      ":lua require('telescope.builtin').colorscheme({enable_preview = true})<CR>",
      "Theme",
    },
  },
  l = {
    a = { ": lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    b = { ": Telescope lsp_document_diagnostics()<CR>", "Document Diagnostics" },
    d = { ":lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
    D = { ":lua vim.lsp.buf.declaration()<CR>", "Go to Declaration" },
    f = { ":lua vim.lsp.buf.format()<CR>", "Format" },
    h = { ":lua vim.lsp.buf.hover()<CR>", "Hover" },
    i = { ":lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
    I = { ":LspInfo<CR>", "Lsp Info" },
    j = { ":lua vim.diagnostic.goto_next()<CR>", "Go to Next Diagnostic" },
    k = { ":lua vim.diagnostic.goto_prev()<CR>", "Go to Previous Diagnostic" },
    l = { ":lua vim.diagnostic.open_float()<CR>", "Show Diagnostics" },
    q = { ":lua vim.diagnostic.setloclist()<CR>", "Open Diagnostics" },
    r = { ":Telescope lsp_references<CR>", "Find References" },
    R = { ":lua vim.lsp.buf.rename()<CR>", "Refactor" },
    s = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
    w = { ":Telescope lsp_workspace_diagnostics<CR>", "Workspace Diagnostics" },
  },
  p = {
    c = { ":PackerCompile<CR>", "Compile" },
    i = { ":PackerInstall<CR>", "Install" },
    s = { ":PackerSync<CR>", "Sync" },
    S = { ":PackerStatus<CR>", "Status" },
    u = { ":PackerUpdate<CR>", "Update" },
  },
  t = {
    f = { ":ToggleTerm direction=float<CR>", "Float" },
    h = { ":ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
    n = { ":lua _TOGGLE_CLI('node')<CR>", "Node" },
    p = { ":lua _TOGGLE_CLI('ipython')<CR>", "Python" },
    t = { ":lua _TOGGLE_CLI('gotop')<CR>", "Top" },
    v = { ":ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
  },
}

for key1, keybinds in pairs(leaderMappings) do
  for key2, action in pairs(keybinds) do
    mappings.n["<leader>" .. key1 .. key2] = action
  end
end

for mode, modeMappings in pairs(mappings) do
  for keybinds, action in pairs(modeMappings) do
    keymap(
      mode,
      keybinds,
      action[1],
      vim.tbl_extend("force", opts, { desc = action[2] })
    )
  end
end
