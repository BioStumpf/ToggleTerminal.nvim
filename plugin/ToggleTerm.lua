local term = require("ToggleTerm")

vim.api.nvim_create_autocmd("WinResized", {
		callback = function ()
			term.rescale_resize_term()
		end
})
