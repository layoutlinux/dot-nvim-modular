return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" }, -- Black es el estándar de facto
      sh = { "shfmt" },              -- Para tus scripts de Zsh/Bash
    },
    format_on_save = {
      lsp_fallback = true,           -- Si no hay formateador, usa el LSP
      timeout_ms = 500,
    },
  },
}
