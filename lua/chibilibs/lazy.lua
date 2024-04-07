-- Lazy.nvim bootstrap

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- {
  --     "folke/tokyonight.nvim",
  --     lazy = false,
  --     priority = 1000,
  --     opts = {},
  --     config = function()
  --         require("tokyonight").setup({
  --             style = "night",
  --             light_style = "day",
  --             transparent = true,
  --             terminal_colors = true,
  --         })
  --         vim.cmd("colorscheme tokyonight")
  --     end,
  -- },

  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     require("rose-pine").setup({
  --       variant = "main",
  --       styles = {
  --         transparency = true
  --       },
  --     })
  --     vim.cmd("colorscheme rose-pine")
  --   end
  -- },

  {
    "Yazeed1s/oh-lucy.nvim",
    config = function()
      vim.g.oh_lucy_evening_trasnparent_brackground = true
      vim.g.oh_lucy_evening_italic_booleans = true
      vim.cmd.colorscheme = "oh-lucy-evening"
    end
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  { "nvim-treesitter/nvim-treesitter", name = "treesitter", cmd = "TSUpdate" },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "theprimeagen/harpoon",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },

      -- Beaulty
      { "onsails/lspkind.nvim" },

      -- TailwindCSS
      { "luckasRanarison/tailwind-tools.nvim" }
    },
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },

  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   opts = {
  --     user_default_options = {
  --       tailwind = true,
  --     },
  --   },
  -- },

  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup({
        copy_sync = {
          redirect_to_clipboard = true,
        },
      })
    end,
  },

  {
    "nvimdev/guard.nvim",
    dependencies = {
      "nvimdev/guard-collection",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "rcarriga/nvim-notify",
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },

  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*", -- recommended, use latest release instead of latest commit
  --   -- lazy = true,
  --   -- ft = "markdown",
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   -- event = {
  --   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   --   "BufReadPre path/to/my-vault/**.md",
  --   --   "BufNewFile path/to/my-vault/**.md",
  --   -- },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
})
