return {
    'navarasu/onedark.nvim',
    config = function()
        -- Lua
        require('onedark').setup {
            -- Main options --
            style = 'deep',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = false,          -- Show/hide background
            term_colors = true,           -- Change terminal color as per the selected theme style
            ending_tildes = true,         -- Show the end-of-buffer tildes. By default they are hidden
            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = 'none',
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },

            -- Custom Highlights --
            colors = {}, -- Override default colors
            highlights = {
                ["@lsp.type.variable"] = { fg = "$red" },
                ["@property"] = { fg = "$red" },
            }, -- Override highlight groups

            -- Plugins Config --
            diagnostics = {
                darker = true,     -- darker colors for diagnostic
                undercurl = true,  -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
        }
        require('onedark').load()
        vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'orange', bold = true })
    end

}
