return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function () 
		local configs = require("nvim-treesitter.configs")

	      	configs.setup({
		ensure_installed = { 
                "bash", "c", "lua", "vim", "vimdoc", 
                "markdown", "python", "java", "verilog",
                "vhdl", "rust", "go", "cpp", "javascript",
                "html", "regex"
            },
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },  
	})
	end
}
