return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		-- enable syntax highlighting
		highlight = {
			enable = true,
		},
		-- enable indentation
		indent = { enable = true },
		-- enable autotagging (w/ nvim-ts-autotag plugin)
		autotag = { enable = true },
		-- ensure these language parsers are installed
		ensure_installed = {
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
		},
		-- auto install above language parsers
		auto_install = true,
		sync_install = false,
	},
}
