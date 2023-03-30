local M = {}

function M.setup()
    local options = { noremap = true, silent = true }

    vim.api.nvim_set_keymap("", "<c-p>", ":Telescope find_files<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>/", ":Telescope live_grep<CR>", options)

    vim.api.nvim_set_keymap("n", "<leader>fe", ":Neotree<CR>", options)
end

return M
