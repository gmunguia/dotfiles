lvim.leader = "space"
lvim.colorscheme = "nord"
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.mouse = ""
vim.opt.shell = "/bin/sh"

lvim.format_on_save = true
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "graphql", "json" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "eslint",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}

lvim.plugins = {
  {
    "tpope/vim-surround",
    keys = {"c", "d", "y"},
  },
  {
    "tpope/vim-repeat",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
      vim.g.indent_blankline_buftype_exclude = {"terminal"}
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end,
  },
  {
    "arcticicestudio/nord-vim",
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
}

-- Hide annoying bufferline https://github.com/LunarVim/LunarVim/issues/1272
lvim.builtin.bufferline.active = false
vim.opt.showtabline = 1

lvim.keys.normal_mode = {
  ["Q"]= "<NOP>",
  ["<Tab>"] = {
    -- <C-w>v switches window because of custom `which_key` mapping.
    '(winnr("$") == 1) ? "<C-w>v" : "<C-w><C-w>"',
    { noremap = true, expr = true }
  },
  ["<Esc>"] = {
    ":noh<CR>",
    { noremap = true, silent = true }
  },
  ["Y"] = "y$",
  ["n"] = {
    '"Nn"[v:searchforward]',
    { noremap = true, expr = true }
  },
  ["N"] = {
    '"nN"[v:searchforward]',
    { noremap = true, expr = true }
  },
  ["]e"] = "<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
  ["[e"] = "<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
  [";"] = { "<Plug>Lightspeed_s", { noremap = false } },
  [","] = { "<Plug>Lightspeed_S", { noremap = false } },
  ["gt"] = "<cmd>tabnext<cr>",
  ["gT"] = "<cmd>tabprevious<cr>",
}

lvim.keys.visual_mode = {
  ["n"] = {
    '"Nn"[v:searchforward]',
    { noremap = true, expr = true }
  },
  ["N"] = {
    '"nN"[v:searchforward]',
    { noremap = true, expr = true }
  },
  ["<"] = "<gv",
  [">"] = ">gv",
}

lvim.keys.term_mode = {
  ["<Leader><Esc>"] = {
    "<C-\\><C-N>",
    { noremap = false },
  },
}

lvim.builtin.which_key.mappings["b"] = {
  "<cmd>Telescope oldfiles<cr>", "Buffers"
}
lvim.builtin.which_key.mappings["S"] = {
  "<cmd>lua require'spectre'.open()<CR>", "search&replace"
}

lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.disable_window_picker = 1
lvim.builtin.nvimtree.mappings = {
  { key = "<Tab>", cb = "<c-w><c-w>" }
}
lvim.builtin.nvimtree.filters = { dotfiles = false }
lvim.builtin.nvimtree.respect_buf_cwd = 0

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "typescript",
  "css",
  "yaml",
}
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.telescope.defaults.file_ignore_patterns = { "*.lock", "node_modules" }
lvim.builtin.telescope.pickers = {
  find_files = {
    hidden = true
  },
}

lvim.autocommands.custom_groups = {
  -- Allow mappings in terminal.
  { "TermEnter", "*", "set timeoutlen=500" },
  { "TermLeave", "*", "set timeoutlen=100" },
}

lvim.builtin.lualine.style = "default"
