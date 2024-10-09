return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup {
            columns = { "icon" },
            keymaps = {
                ["<C-h>"] = false,
            },
            view_options = {
                show_hidden = true,
            },
        }

        -- Open parent directory in current window
        vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
}
