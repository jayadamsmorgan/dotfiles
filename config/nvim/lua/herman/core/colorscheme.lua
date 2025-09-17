---@diagnostic disable-next-line: param-type-mismatch
local status, _ = pcall(vim.cmd, "colorscheme dracula")
if not status then
	print("Cannot load colorscheme!") -- print error if colorscheme not installed
	return
end

vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none"})
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none"})
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none"})

vim.cmd("highlight WinBar guifg=None guibg=None")
vim.cmd("highlight WinBarNC guifg=None guibg=None")
vim.cmd("highlight StatusLine guifg=None guibg=None")
