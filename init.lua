-- [[ init.lua ]]

--[[ local o = vim.o ]]
--[[ local bo = vim.bo ]]
local g = vim.g
--[[ local wo = vim.wo ]]

require("user.options")
require("user.plugins")
require("user.keymaps")
require("user.colorscheme")
require("user.fidget")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.nvim-tree")
require("user.dashboard")
require("user.lspzero")
--[[ require("user.mason") ]]
-- vim.cmd "colorscheme gloombuddy"
--
-- staline --
-- require("user.stalineOptions")
-- require("user.stablineOptions")
-- lualine --
require("user.lualineOptions")
-- require("user.bufferlineOptions")
require("user.tabline")

g.mapleader = " "
g.t_co = 256
