local M = {}

function M.compile(entrypoint)
	local output = vim.system({
		"nasm",
		"-g",
		"-felf64",
		entrypoint.full_path,
		"-o",
		entrypoint.build_path .. entrypoint.filename .. ".o",
	}, { text = true }):wait()

	if output.code ~= 0 then
		vim.notify(output.stderr, vim.log.levels.ERROR)
		return false
	end
end

function M.link(entrypoint)
	local output = vim.system({
		"ld",
		"-o",
		entrypoint.build_path .. entrypoint.filename,
		entrypoint.build_path .. entrypoint.filename .. ".o",
	}, { text = true }):wait()

	if output.code ~= 0 then
		vim.notify(output.stderr, vim.log.levels.ERROR)
		return false
	end
end

function M.run(entrypoint)
	require("util.floating_terminal").open(entrypoint.build_path .. entrypoint.filename)
end

function M.build(entrypoint)
	if M.compile(entrypoint) == false then
		return false
	end

	if M.link(entrypoint) == false then
		return false
	end
end

function M.build_and_run(entrypoint)
	if M.build(entrypoint) == false then
		return false
	end

	if M.run(entrypoint) == false then
		return false
	end
end

return M
