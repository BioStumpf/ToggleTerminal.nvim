--module table, containing the window and the terminal buffer, but also tracks the scaling of the window (0 - 1) and window height to enable resizing as a reaction of changing the vim/terminal size
M = {}
local win = { window = nil, buf = nil, scale = nil, tot_height = nil}

--open window computes the terminal height based on the user given scale and opens a split window
local function open_window(win)
	local term_height = math.floor(win.scale * win.tot_height) 
	vim.cmd("botright split")
	vim.cmd("noautocmd resize" .. term_height)
	win.window = vim.api.nvim_get_current_win()
end

--close window resets window to nil
local function close_window(win)
	vim.api.nvim_win_close(win.window, true)
	win.window = nil
end

--opens a new buffer and adds the user default terminal to it
local function open_term_buff(win)
    win.buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_call(win.buf, function() vim.fn.termopen(os.getenv("SHELL")) end)
end

--opens the window and attaches the terminal buffer to it
local function buf_to_window(win, ratio)
	open_window(win)
	vim.api.nvim_win_set_buf(win.window, win.buf)
end

--function triggered upon import of plugin as an autocommand, causes rescaling when the vim window size changes
--this is important to keep the appropriate scale if moving the vim window around/ changing its size
local function resize_term()
	if win.window and vim.api.nvim_win_is_valid(win.window) then
		local size = math.floor(win.scale * vim.o.lines)
		vim.api.nvim_win_call(win.window, function () vim.cmd("noautocmd resize " .. size) end)
	end
end

--this is to ensure, that the running the :resize x command on the terminal split window changes the win.scale variable, allowing toggling the terminal using the new size
local function rescale_term()
	if win.window and vim.api.nvim_win_is_valid(win.window) then
		local current_height = vim.api.nvim_win_get_height(win.window)
		local expected_height = math.floor(win.scale * vim.o.lines)
		if current_height ~= expected_height then
			win.scale = current_height / vim.o.lines
		end
	end
end

--this function combines both resizing and rescaling (both tiggered as autocommands when windows are resized)
--see plugin/ folder for usage
function M.rescale_resize_term()
	local old_tot_height = win.tot_height
	win.tot_height = vim.o.lines

	if old_tot_height ~= vim.o.lines then
		resize_term()
	else
		rescale_term()
	end
end

--function allowing to toggle the terminal
function M.toggle_term(ratio)
	if not win.tot_height then
		win.tot_height = vim.o.lines
	end
	if not win.scale then
		win.scale = ratio
	end
	if win.window and vim.api.nvim_win_is_valid(win.window) then
		close_window(win)
		return
	end
	if not win.buf or not vim.api.nvim_buf_is_valid(win.buf) then
		open_term_buff(win)
	end
	buf_to_window(win)
end

return (M)
