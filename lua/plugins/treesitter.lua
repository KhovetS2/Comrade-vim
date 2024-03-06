return{
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function() 
      local config = require('nvim-treesitter.configs')
      config.setup {
      ensure_installed = { "c","javascript","typescript","python", "lua", "vim", "vimdoc", "query" },

        sync_install = false,

        auto_install = true,

        indent ={ enable = true },
        highlight = {
          enable = true,

          additional_vim_regex_highlighting = false,
        }
      }
    end
  }
