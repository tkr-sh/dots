-- In case packer isn't installed
pcall(function()

-- Enable cursorline by default
vim.opt.cursorline = true

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Add the correct theme
vim.cmd('colorscheme tkirishima')

-- Set default things
require("tkirishima/set")

-- Tree settings
require("tree")

-- Vim status line
require('feline-plugin')

-- LSP section
local lsp = require('lsp-zero')

lsp.preset('recommended')
-- on_attach
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

-- Set the default highlighting
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
})


require'lspconfig'.pylsp.setup {
    on_attach=on_attach,
    filetypes = {'python'},
    settings = {
        configurationSources = {"flake8"},
        formatCommand = {"black"},
        pylsp = {
            plugins = {
                jedi_completion = {
                    include_params = true,
                },
                jedi_signature_help = {enabled = true},
                jedi = {
                    extra_paths = {'~/projects/work_odoo/odoo14', '~/projects/work_odoo/odoo14'},
                    -- environment = {"odoo"},
                },
                pyflakes={enabled=true},
                -- pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
                pylsp_mypy={enabled=false},
                pycodestyle={
                    enabled=true,
                    ignore={'E501', 'E231', "E266", "E303", "E731"},
                    maxLineLength=120
                },
                yapf={enabled=true}
            }
        }
    }
}


lsp.setup()



local prettier = require("prettier")

prettier.setup({
    bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
});



end)


-- Packer pkg 
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'


    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }





    -- Syntax highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        {
            run = ":TSUpdate"
        }
    }

    use {
        "nvim-treesitter/playground"
    }


    -- The bar
    use 'famiu/feline.nvim'

    -- The undo tree
    use "mbbill/undotree"

    -- Indent line
    use {
        "lukas-reineke/indent-blankline.nvim",
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- Add css color
    use 'lilydjwg/colorizer'

    -- Auto rename
    use 'AndrewRadev/tagalong.vim'

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        },

        -- Better syntax highlighting
        use { "sheerun/vim-polyglot" }
    }

    -- Auto close tag
    use { 'alvan/vim-closetag' }

    -- Instant markdown
    use { 'instant-markdown/vim-instant-markdown' }

    -- Git support
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                signs = {
                    add          = { text = '+' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
                yadm = {
                    enable = false
                },
            }
        end
    }


    -- Use more icons
    use { 'ryanoasis/vim-devicons' }

    -- Comment
    use { 'tpope/vim-commentary' }

    -- Markdown table of contents
    use { 'mzlogin/vim-markdown-toc' }
    
    -- Prettier
    use('neovim/nvim-lspconfig')
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')
end)
