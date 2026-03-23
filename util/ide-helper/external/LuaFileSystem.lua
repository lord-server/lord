---@meta

--- LuaFileSystem (lfs) library annotations
---@class lfs
local lfs = {}

--- Returns file attributes or nil and error message
--- @param filepath string Path to the file
--- @param aname? string Optional attribute name to return only specific attribute
--- @return table|nil attributes Table of file attributes or nil
--- @return string? error Error message if operation failed
function lfs.attributes(filepath, aname) end

--- Changes current directory, returns true or nil and error
--- @param path string Path to change to
--- @return boolean|nil success True if successful or nil
--- @return string? error Error message if operation failed
function lfs.chdir(path) end

--- Returns current working directory
--- @return string path Current working directory path
function lfs.currentdir() end

--- Iterator over directory entries
--- @param path string Directory path to iterate over
--- @return fun():string? iterator Function that returns next entry or nil
function lfs.dir(path) end

--- Locks a file, returns true or nil and error
--- @param filehandle file* File handle to lock
--- @param mode string Lock mode ('r' for read, 'w' for write, 'u' for unlock)
--- @param start? integer Optional start position (default: 0)
--- @param length? integer Optional lock length (default: whole file)
--- @return boolean|nil success True if successful or nil
--- @return string? error Error message if operation failed
function lfs.lock(filehandle, mode, start, length) end

--- Creates a lock directory, returns lock table or nil and error
--- @param path string Path for lock directory
--- @param seconds_stale? number Seconds after which lock is considered stale (default: infinite)
--- @return table|nil lock Lock table with 'lock_dir' and 'unlock' fields or nil
--- @return string? error Error message if operation failed
function lfs.lock_dir(path, seconds_stale) end

--- Creates a directory, returns true or nil and error
--- @param dirname string Directory name to create
--- @return boolean|nil success True if successful or nil
--- @return string? error Error message if operation failed
function lfs.mkdir(dirname) end

--- Removes a directory, returns true or nil and error
--- @param dirname string Directory name to remove
--- @return boolean|nil success True if successful or nil
--- @return string? error Error message if operation failed
function lfs.rmdir(dirname) end

--- Sets file mode, returns previous mode or nil and error
--- @param file file* File handle
--- @param mode string New mode ('binary' or 'text')
--- @return string|nil previous_mode Previous mode or nil
--- @return string? error Error message if operation failed
function lfs.setmode(file, mode) end

--- Returns symlink attributes or nil and error message
--- @param filepath string Path to the symlink
--- @param aname? string Optional attribute name to return only specific attribute
--- @return table|nil attributes Table of symlink attributes or nil
--- @return string? error Error message if operation failed
function lfs.symlinkattributes(filepath, aname) end

--- Sets file times, returns true or nil and error
--- @param filepath string Path to the file
--- @param atime? number Optional access time (default: current time)
--- @param mtime? number Optional modification time (default: current time)
--- @return boolean|nil success True if successful or nil
--- @return string? error Error message if operation failed
function lfs.touch(filepath, atime, mtime) end

--- Unlocks a file, returns true or nil and error
--- @param filehandle file* File handle to unlock
--- @param start? integer Optional start position (default: 0)
--- @param length? integer Optional lock length (default: whole file)
--- @return boolean|nil success True if successful or nil
--- @return string? error Error message if operation failed
function lfs.unlock(filehandle, start, length) end

--- Creates a link, returns true or nil and error
--- @param old string Target path
--- @param new string Link path
--- @param symlink? boolean If true creates symbolic link, otherwise hard link
--- @return boolean|nil success True if successful or nil
--- @return string? error Error message if operation failed
function lfs.link(old, new, symlink) end

--- Reads symlink target or nil and error
--- @param path string Path to the symlink
--- @return string|nil target Target path or nil
--- @return string? error Error message if operation failed
function lfs.readlink(path) end


return lfs
