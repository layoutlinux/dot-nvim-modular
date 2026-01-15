return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 1. Mason-LSPConfig para asegurar la instalación
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "bashls" },
      })

      -- 2. Capabilities para el autocompletado
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 3. Configuración NATIVA (Neovim 0.11+)
      -- En lugar de lspconfig.server.setup, usamos vim.lsp.enable
      -- Esto utiliza el nuevo framework interno que no lanza avisos de deprecación
      
      -- Python
      vim.lsp.enable("pyright", { capabilities = capabilities })
      
      -- Bash / Zsh
      vim.lsp.enable("bashls", { 
        capabilities = capabilities,
        filetypes = { "sh", "zsh" } 
      })
      
      -- Lua
      vim.lsp.enable("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      -- 4. Mapeos (Se mantienen igual)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
