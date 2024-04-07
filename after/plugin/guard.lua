local ft = require("guard.filetype")

ft("lua"):fmt("lsp"):append("stylua")

--ft("typescript,javascript,typescriptreact"):fmt("biome")

ft("rust"):fmt("lsp"):append("rustfmt")
ft("go"):fmt("gofmt"):append("lsp")

-- Call setup() LAST!
require("guard").setup({
    -- the only options for the setup function
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = true,
})

vim.keymap.set("n", "<leader>cf", ":GuardFmt<CR>")
