return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local c = require('onedark.colors')
        local cfg = vim.g.onedark_config
        local colors = {
            bg = c.bg0,
            fg = c.fg,
            red = c.red,
            green = c.green,
            yellow = c.yellow,
            blue = c.blue,
            purple = c.purple,
            cyan = c.cyan,
            gray = c.grey
        }

        local one_dark = {
            inactive = {
                a = { fg = colors.gray, bg = colors.bg, gui = 'bold' },
                b = { fg = colors.gray, bg = colors.bg },
                c = { fg = colors.gray, bg = cfg.lualine.transparent and c.none or c.bg1 },
            },
            normal = {
                a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
                b = { fg = colors.fg, bg = c.bg3 },
                c = { fg = colors.fg, bg = cfg.lualine.transparent and c.none or c.bg1 },
            },
            visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
            replace = { a = { fg = colors.bg, bg = colors.red, gui = 'bold' } },
            insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
            command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
            terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
        }
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = one_dark,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 2 } },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end
}
