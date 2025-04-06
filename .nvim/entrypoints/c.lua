local M = {}

local function open_floating_terminal(cmd)
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.6)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.fn.termopen(cmd, {
		on_exit = function()
			vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>bd!<CR>", { noremap = true, silent = true })
		end,
	})

	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "terminal"
end

function M.compile(entrypoint)
	local output = vim.system(
		{ "gcc", entrypoint.full_path, "-o", entrypoint.build_path .. entrypoint.filename },
		{ text = true }
	):wait()

	if output.code ~= 0 then
		vim.notify(output.stderr, vim.log.levels.ERROR)
		return false
	end
end

function M.run(entrypoint)
	open_floating_terminal(entrypoint.build_path .. entrypoint.filename)
end

function M.build_and_run(entrypoint)
	if M.compile(entrypoint) == false then
		return false
	end

	if M.run(entrypoint) == false then
		return false
	end
end

return M
