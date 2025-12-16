local term = require("toggle_term")

vim.api.nvim_create_autocmd("WinResized", {
		callback = function ()
			term.rescale_resize_term()
		end
})
