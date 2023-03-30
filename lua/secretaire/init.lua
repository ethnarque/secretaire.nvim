local M = {}

function M.setup()
    local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    end
    vim.opt.rtp:prepend(lazypath)

    require "secretaire.options"

    require("lazy").setup({
        { import = "secretaire.plugins" },
    }, {
        change_detection = { notify = false },
    })

    require "secretaire.config.keymaps"
end

return M
