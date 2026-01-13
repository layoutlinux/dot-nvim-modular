return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Función para mostrar el conteo de búsqueda
    local function search_result()
      if vim.v.hlsearch == 0 then return '' end
      local last_search = vim.fn.getreg('/')
      if not last_search or last_search == '' then return '' end
      local searchcount = vim.fn.searchcount { maxcount = 9999 }
      return last_search .. ' (' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    require('lualine').setup({
      options = {
        theme = 'catppuccin',
        
        section_separators = { left = '', right = '' },
        component_separators = '',
        globalstatus = true, 
      },
      sections = {
        lualine_a = { { 'mode', separator = { right = '' }, right_padding = 2 } },
        lualine_b = {
          'branch',
          'diff',
          { 'diagnostics', sources = { 'nvim_diagnostic' } },
        },
        lualine_c = {
          { 'filename', file_status = true, path = 1 },
        },
        lualine_x = {
          {
            'searchcount', 
            maxcount = 999,
            timeout = 500,
          },
        },
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { '%l:%c', separator = { left = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end
}
