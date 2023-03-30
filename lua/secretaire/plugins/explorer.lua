local util = require "secretaire.utils"

return {
    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false,
        keys = {
            { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
            { "<leader>/", util.telescope "live_grep", desc = "Grep (root dir)" },
            { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            -- find
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>ff", util.telescope "files", desc = "Find Files (root dir)" },
            { "<leader>fF", util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
            { "<leader>fR", util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        },
    },

    -- file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute { toggle = true, dir = require("secretaire.utils").get_root() }
                end,
                desc = "Explorer NeoTree (root dir)",
            },
            {
                "<leader>fE",
                function()
                    require("neo-tree.command").execute { toggle = true, dir = vim.loop.cwd() }
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
            { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
        },
        deactivate = function()
            vim.cmd [[Neotree close]]
        end,
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require "neo-tree"
                end
            end
        end,
        opts = {
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
                use_libuv_file_watcher = true,
            },
            window = {
                position = "right",
                mappings = {
                    ["<space>"] = "none",
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },
}
