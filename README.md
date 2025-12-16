# ToggleTerminal.nvim
This repository hosts a very simple terminal for nvim

## What it can do:
The key function is the toggle_term(scale) function. Scale can be any number between 0 and 1, it specifies how much space the terminal split window takes up proportional to nvims total window size.   
ToggleTermal also enables felxible vertical resizing of the terminal window, if using :resize x, it remembers the altered scale.   
If minimizing/ draging, the terminal window keeps this proportional scale. Note however that it only keeps proportion of the terminal window itself, not any other split window, which may lead to distorting split arrangments during drag/ minimizing the vim window.

## Setup
Since this plugin is extremely basic, it does not posess a setup function. The only thing that needs to be specified are the keybindings for toggling.   
For lazy.nvim:
```
return {
	{ dir = "toggle_term.nvim/",
	keys = {
		{"<leader>tt", function() require("toggle_term").toggle_term(0.3) end },
		{"<leader>tt", function() require("toggle_term").toggle_term(0.3) end, mode = "t" }
		}
	}
}
```
