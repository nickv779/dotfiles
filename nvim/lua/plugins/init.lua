return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    lazy = false,
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type for details
      }

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function()
        require("opencode").ask("@this: ")
      end, { desc = "Ask OpenCode…" })

      vim.keymap.set({ "n", "x" }, "<C-x>", function()
        require("opencode").select()
      end, { desc = "Select OpenCode…" })

      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator("@this ")
      end, { desc = "Append range to OpenCode", expr = true })

      vim.keymap.set({ "n" }, "goo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { desc = "Append line to OpenCode", expr = true })

      vim.keymap.set({ "n" }, "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end,   { desc = "Scroll OpenCode up" })

      vim.keymap.set({ "n" }, "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Scroll OpenCode down" })

    end,
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      input = {
        ask = true
      },
      picker = {
        enabled = true, -- Enhances Select
        win = {
          input = {
            keys = {
              ["<a-o>"] = { "opencode_send", mode = { "n", "i" } },
            },
          },
        },
        actions = {
          opencode_send = function(picker) ---@param picker snacks.Picker
            local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
              return item.file
                and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
                or item.text
            end, picker:selected({ fallback = true }))

            require("opencode").prompt(table.concat(items, ", ") .. " ")
          end,
        },
      },
    },
  },

  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      {
        "ray-x/guihua.lua",
        build = "cd lua/fzy && make",
      },
      "neovim/nvim-lspconfig",
      { "nvim-treesitter/nvim-treesitter", branch = 'main' } -- optional for master version
    },
    ft = { "go", "gomod", "gowork", "gosum" },
    opts = {
      lsp_keymaps = false,
      lsp_cfg = true,
      verbose = false,
      log_path = vim.fn.stdpath('cache') .. '/gonvim.log',
    },
    config = function(_, opts)
      require("go").setup(opts)

      local group = vim.api.nvim_create_augroup("GoFormat", { clear = true })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
      })
    end,
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function ()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "neovim/nvim-lspconfig"
  --   },
  --   opts = function()
  --     local cmp = require "cmp"
  --
  --     local config = {
  --       completion = {
  --         completeopt = "menu,menuone,noselect",
  --       },
  --
  --       preselect = cmp.PreselectMode.None
  --     }
  --
  --     return config
  --   end,
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc","html", "css"
      },
    },
  },

  {
    'iberianpig/tig-explorer.vim',
    dependencies = { 'rbgrouleff/bclose.vim' }, -- required for Neovim
  },
}
