-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- require("nvim-tree").setup({
--     sort_by = "extension",
--     renderer = {
--       group_empty = true,
--     },
--     filters = {
--       dotfiles = false,
--     },
-- })


local function sort_by_extension_then_name(a, b)
  if a.type == b.type then
    -- Sort files and directories with the same extension alphabetically by name
    if a.extension == b.extension then
      return a.path < b.path
    else
      -- Sort files and directories by extension alphabetically
      return a.extension < b.extension
    end
  else
    -- Sort files before directories
    return a.type < b.type
  end
end


local highlights = require("neo-tree.ui.highlights")
require("neo-tree").setup({
    close_if_last_window = false,
    popup_border_style = "rounded",
    sort_case_insensitive = true,
    hide_hidden = false,
    source_selector = {
      winbar = true,
      statusline = false
    },
    sort_function = function(a,b)
      if a.type == b.type then
        local ext_a = a.path:match("^.+%.(.+)$") or ""
        local ext_b = b.path:match("^.+%.(.+)$") or ""

        -- Sort files and directories with the same extension alphabetically by name
        if ext_a == ext_b then
          return a.path < b.path
        else
          -- Sort files and directories by extension alphabetically
          return ext_a < ext_b
        end
      else
        -- Sort files before directories
        return a.type < b.type
      end
    end,
    filesystem = {
      components = {
        icon = function(config, node, state)
          local icon = config.default or " "
          local padding = config.padding or " "
          local highlight = config.highlight or highlights.FILE_ICON

          if node.type == "directory" then
            highlight = highlights.DIRECTORY_ICON
            if node:is_expanded() then
              icon = config.folder_open .. " "
            else
              icon = config.folder_closed or "+"
            end
            icon = icon .. " "
          elseif node.type == "file" then
            local success, web_devicons = pcall(require, "nvim-web-devicons")
            if success then
              local devicon, hl = web_devicons.get_icon(node.name, node.ext)
              icon = devicon or icon
              highlight = hl or highlight
            end
          end

          return {
            text = icon .. padding,
            highlight = highlight,
          }
      end
      }
    }
  })


-- The tree
vim.g.mapleader = " "


-- Map a keybinding to toggle NvimTree
-- vim.api.nvim_set_keymap('n', '<leader>b', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':NeoTreeShowToggle<CR>', { noremap = true, silent = true })

-- Change the focus with leader e
vim.api.nvim_set_keymap('n', '<leader>e', '<C-w>w', { noremap = true, silent = true })
