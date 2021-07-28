local HTTP = HTTP
local SHA1 = util.SHA1
local deleteFile = file.Delete
local findFile = file.Find
local openFile = file.Open
local renameFile = file.Rename
local writeFile = file.Write
local ErrorNoHalt = ErrorNoHalt
module("webmat")

function Exists(hash)
	local img = findFile("webmats/" .. hash .. ".*", "DATA")[1]

	return img and true or false, img
end

function Download(uri, cb)
	HTTP({
		failed = ErrorNoHalt,
		success = function(code, body)
			local str = SHA1(body)
			local exists, hash = Exists(str)

			if exists then
				str = hash
			else
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
					ErrorNoHalt("Invalid URI entered for webmat.Download!")
				end
			end

			cb(str) -- something has to be better than this shit
		end,
		method = "GET",
		url = uri
	})
end
