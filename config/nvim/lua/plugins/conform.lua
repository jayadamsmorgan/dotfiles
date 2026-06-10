return {
	"stevearc/conform.nvim",
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
	opts = {
		formatters = {
			dtsformat = {
				command = "dtsformat",
			},
		},
		formatters_by_ft = {
			dts = { "dtsformat" },
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			cxx = { "clang-format" },
			objc = { "clang-format" },
			objcpp = { "clang-format" },
			python = { "yapf" },
		},
	},
}
