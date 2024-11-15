local tbuiltin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", tbuiltin.find_files, {})
vim.keymap.set("n", "<C-p>", tbuiltin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	tbuiltin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>vh", tbuiltin.help_tags, {})

require("telescope").setup({
	defaults = {
		file_ignore_patterns = {},
		find_command = { "rg", "--files", "--hidden", "--follow", "--glob", "!.git" },
	},
})
