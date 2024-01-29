require('io')
local module_name = 'utils'
local module_path = package.searchpath(module_name, package.path)

if not module_path then
    print('Could not access location of module: ' .. module_name)
    return {}
end

-- module_path without the module name
local module_folder = module_path:sub(1, module_path:find(module_name) - 2)

if module_folder == '.' then
    module_folder = ''
end

local path_separator = package.config:sub(1, 1)

local M = {}

local function join_paths(path1, path2)
    if path1 == '' then
        return path2
    elseif path2 == '' then
        return path1
    end

    return path1 .. path_separator .. path2
end

-- Function: list_dir
-- Description: list all files in a directory
-- Parameters:
--  dir: directory to list the contents of
--  recursive: whether to list recursively
-- Returns:
-- table of file paths as strings
local function list_dir(dir, recursive)
    local recursive_flag = recursive and '-r' or ''
    local cmd = join_paths(module_folder, 'list_dir.exe')
        .. ' '
        .. dir
        .. ' '
        .. recursive_flag
    print('Running: ' .. cmd)
    local handle = io.popen(cmd)

    if not handle then
        return {}
    end

    local files = {}
    for file in handle:lines() do
        table.insert(files, file)
    end

    handle:close()

    return files
end
M.list_dir = list_dir

return M
