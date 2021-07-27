local HTTP = HTTP
local SHA1 = util.SHA1
local deleteFile = file.Delete
local openFile = file.Open
local renameFile = file.Rename
local writeFile = file.Write
local ErrorNoHalt = ErrorNoHalt
module("webmat")

function Download(uri)
	local str

	if HTTP({
		failed = ErrorNoHalt,
		success = function(code, body)
			str = SHA1(body)
			local oldname = "webmats/" .. str .. ".dat"
			writeFile(oldname, body)
			local f = openFile(oldname, "rb", "DATA")
			f:Skip(1)
			local ispng = f:Read(3) == "PNG"
			f:Skip(2)
			local isjpg = f:Read(4) == "JFIF"
			f:Close()

			if ispng then
				str = str .. ".png"
				renameFile(oldname, "webmats/" .. str)
			elseif isjpg then
				str = str .. ".jpg"
				renameFile(oldname, "webmats/" .. str)
			else
				str = nil
				deleteFile(oldname)
			end
		end,
		method = "GET",
		url = uri
	}) then
		return str
	end
end