local lsp = require("lsp-zero")

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

--lsp.preset("recommended")

lsp.ensure_installed({
  "lua_ls",
  "rust_analyzer",
  "gopls",
  "tsserver",
  "biome",
  "tailwindcss",
  "clangd",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local lspkind = require('lspkind')
local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

require("tailwind-tools").setup({
  document_color = {
    enabled = true, -- can be toggled by commands
    kind = "foreground", -- "inline" | "foreground" | "background"
    inline_symbol = "󰝤 ", -- only used in inline mode
    debounce = 200, -- in milliseconds, only applied in insert mode
  },
})
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    --
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        emoji = "[Emoji]",
        luasnip = "[LuaSnip]",
      }),
      before = require("tailwind-tools.cmp").lspkind_format
    }),
  },
})

cmp.config.formatting = {
  format = require("tailwindcss-colorizer-cmp").formatter
}

lsp.set_preferences({
  suggest_lsp_servers = true,
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  },
})

lsp.setup({
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set("n", "<leader>vrr", function()
    vim.lsp.buf.references()
  end, opts)
  vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, opts)
end)

require("lspconfig").clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "-j=24",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
  },
})

require("lspconfig").ltex.setup({
  settings = {
    ltex = {
      language = "pt-BR",
    },
  },
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
