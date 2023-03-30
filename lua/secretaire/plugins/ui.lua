return {
    -- better vim.ui
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load { plugins = { "dressing.nvim" } }
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load { plugins = { "dressing.nvim" } }
                return vim.ui.input(...)
            end
        end,
    },

    -- noicer ui
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "folke/which-key.nvim",
                opts = function(_, opts)
                    if require("secretaire.utils").has "noice.nvim" then
                        -- opts.defaults["<leader>sn"] = { name = "+noice" }
                    end
                end,
            },
        },
        opts = {
            messages = {
                enable = false,
                -- view = "virtualtext",
                view_search = "notify",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
            -- @ Show @recording message
            routes = {
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
            },
        },
        -- stylua: ignore
        keys = {
        --     { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
        --     { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
                { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
        --     { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
        --     { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
        --     { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
        --     { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
        },
        -- stylua: end ignore
    },

    -- Better `vim.notify()`
    -- {
    --     "rcarriga/nvim-notify",
    --     keys = {
    --         {
    --             "<leader>un",
    --             function()
    --                 require("notify").dismiss { silent = true, pending = true }
    --             end,
    --             desc = "Dismiss all Notifications",
    --         },
    --     },
    --     ---@type notify.Options
    --     opts = {
    --         timeout = 3000,
    --         max_height = function()
    --             return math.floor(vim.o.lines * 0.75)
    --         end,
    --         max_width = function()
    --             return math.floor(vim.o.columns * 0.75)
    --         end,
    --     },
    --     init = function()
    --         vim.notify = require "notify"
    --         -- when noice is not enabled, install notify on VeryLazy
    --         local util = require "secretaire.utils"
    --         if not util.has "noice.nvim" then
    --             util.on_very_lazy(function()
    --                 vim.notify = require "notify"
    --             end)
    --         end
    --     end,
    -- },

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local dashboard = require "alpha.themes.dashboard"
            local logo = [[
        ███████╗███████╗ ██████╗██████╗ ███████╗████████╗ █████╗ ██╗██████╗ ███████╗
        ██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██║██╔══██╗██╔════╝
        ███████╗█████╗  ██║     ██████╔╝█████╗     ██║   ███████║██║██████╔╝█████╗
        ╚════██║██╔══╝  ██║     ██╔══██╗██╔══╝     ██║   ██╔══██║██║██╔══██╗██╔══╝
        ███████║███████╗╚██████╗██║  ██║███████╗   ██║   ██║  ██║██║██║  ██║███████╗
        ╚══════╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝
      ]]

            dashboard.section.header.val = vim.split(logo, "\n")
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("l", "󰒲 " .. " Plugins", ":Lazy<CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {},
    },
}
