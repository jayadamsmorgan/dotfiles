return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local ts = require("nvim-treesitter")

		ts.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local ensure_installed = {
			"swift",
			"java",
			"python",
			"cpp",
			"c",
			"json",
			"yaml",
			"html",
			"markdown",
			"markdown_inline",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"gitcommit",
		}

		ts.install(ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf = args.buf
				local ft = vim.bo[buf].filetype

				if ft == "" then
					return
				end

				pcall(vim.treesitter.start, buf)
			end,
		})
	end,
}
