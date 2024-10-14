-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(_, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "<leader>K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
	keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format()
	end, opts)
	keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	keymap.set("n", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.cmd([[autocmd BufRead,BufNewFile *.qmltypes setfiletype qmltypes]])
vim.cmd([[autocmd BufRead,BufNewFile *.swiftinterface setfiletype swift]])
vim.cmd([[autocmd BufRead,BufNewFile *.qrc setfiletype xml]])

local configs = require("lspconfig.configs")

local qmlls_root_dir_fun = lspconfig.util.root_pattern(".qmlls.ini", "*.pro", ".git", ".")
local qmlls_root_dir = qmlls_root_dir_fun(vim.fn.getcwd()) -- or replace vim.fn.getcwd() with another appropriate function
configs.qmlls = {
	default_config = {
		cmd = { "qmlls", "-b", qmlls_root_dir .. "/build" },
		filetypes = { "qml" },
		root_dir = qmlls_root_dir_fun,
		settings = {},
	},
}

lspconfig["qmlls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("pklls-nvim.init").setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		-- "/home/ubuntu/Documents/PklLanguageServer/.build/debug/pkl-lsp-server", -- debug version
		"pkl-lsp-server", -- release version
		-- "--enable-experimental-features",
		-- "--import-depth",
		-- "3",
	},
})

-- configure yaml server
lspconfig["yamlls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- configure json server
lspconfig["jsonls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
-- configure bash server
lspconfig["bashls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- configure python server
lspconfig["pylsp"].setup({
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					enabled = false,
				},
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig["sourcekit"].setup({
	filetypes = { "swift", "objc", "objcpp", "cuda", "proto" },
	cmd = {
		"sourcekit-lsp",
	},
	root_dir = lspconfig.util.root_pattern("Package.swift", "project.yml", "Project.swift", ".git", "."),
	on_attach = on_attach,
	capabilities = capabilities,
})

-- configure c/c++ server
lspconfig["clangd"].setup({
	cmd = {
		"clangd",
		"--header-insertion=never",
		"--background-index",
		"--clang-tidy",
		"--limit-references=0",
		"--limit-results=0",
		"--log=error",
		"--offset-encoding=utf-16",
		"--function-arg-placeholders=false",
		--"--query-driver=/Applications/ArmGNUToolchain/13.2.Rel1/arm-none-eabi/bin/*gcc*",
		-- "--query-driver=/usr/bin/aarch64-linux-gnu-gcc*",
		-- "--query-driver=/**/*",
		-- "--query-driver=/Users/hermanberdnikov/.platformio/packages/toolchain-xtensa-esp32s3/bin/*gcc*",
		"--query-driver=/opt/homebrew/bin/arm-none-eabi-gcc",
	},
	filetypes = { "c", "cpp", "arduino" },
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig["kotlin_language_server"].setup({
	cmd = { "/home/ubuntu/Documents/kotlin-language-server/server/build/install/server/bin/kotlin-language-server" },
	-- root_dir = require("lspconfig/util").root_pattern(".git", "build.gradle", "pom.xml"),
	on_attach = on_attach,
	capabilities = capabilities,
})

-- configure java server
lspconfig["jdtls"].setup({
	-- cmd = { "/usr/local/Cellar/jdtls/1.26.0/bin/jdtls" },
	root_dir = require("lspconfig/util").root_pattern(".git", "pom.xml"),
	on_attach = on_attach,
	capabilities = capabilities,
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
