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
		}

		ts.install(ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_auto_start", { clear = true }),
			callback = function(args)
				local buf = args.buf
				local ft = vim.bo[buf].filetype

				if ft == "" or ft == "NvimTree" then
					return
				end

				-- Try to start treesitter.
				local ok = pcall(vim.treesitter.start, buf)

				if ok then
					return
				end

				-- If parser is missing, try installing parser matching the filetype,
				-- then start treesitter after install finishes.
				local install_ok, install_result = pcall(ts.install, { ft })

				if install_ok and install_result then
					install_result:wait(300000)
					pcall(vim.treesitter.start, buf)
				end
			end,
		})
	end,
}
