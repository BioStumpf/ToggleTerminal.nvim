# ToggleTerminal.nvim
A minimal, toggleable terminal for Neovim.

## Features
The core functionality is provided by the toggle_term(scale) function. The scale parameter accepts a value between 0 and 1, determining the portion of the Neovim window that the terminal split occupies.    

ToggleTerminal.nvim also supports flexible vertical resizing: if you adjust the terminal with :resize x (or drag it), it will remember the new scale. When changing the total terminal window size, the proportional scale is preserved. Note that this scaling applies only to the terminal itself, not other split windows, which may cause layout distortions when resizing or minimizing the Neovim window.

## Setup
This plugin is intentionally minimal and does not include a setup function. The only required configuration is defining your keybindings for toggling the terminal.

For lazy.nvim users:
```
return {
	"BioStumpf/ToggleTerminal.nvim",
	lazy = false,
	keys = {
		{"<leader>tt", function() require("ToggleTerm").toggle_term(0.3) end },
		{"<leader>tt", function() require("ToggleTerm").toggle_term(0.3) end, mode = "t" }
	}
}
```
