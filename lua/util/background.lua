local M = {}

Path = ""

local function get_files(dir)
    local files_str = vim.fn.globpath(dir, '*')
    local files = vim.split(files_str, '\n')
    return files
end

local function set_background(folder)
	Path = "/home/danielr/.config/kitty/bg/" .. folder
	local files = get_files(Path)

	local file = files[math.random(#files)]
	vim.fn.system("kitty @ --to=$KITTY_LISTEN_ON set-background-image " .. file)
end

function M.getBackground()
	local command = "ls /home/danielr/.config/kitty/bg/"
	local handle = io.popen(command)
	if handle then
		local result = handle:read("*a")
		handle:close()
		print(result)
	end
	local folder = vim.fn.input("\n Choose folder: ")

	if folder then
		set_background(folder)
	end
end

function M.changeBackground()
	local files = get_files(Path)

	local file = files[math.random(#files)]
	vim.fn.system("kitty @ --to=$KITTY_LISTEN_ON set-background-image " .. file)
end

return M
