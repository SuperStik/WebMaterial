local HTTP = HTTP
local SHA1 = util.SHA1
local writeFile = file.Write
local ErrorNoHalt = ErrorNoHalt
local error = error
module("webmat")

local function successjpeg(code, body)
	writeFile("webmats/" .. SHA1(body) .. ".jpg", body)
end

local function successpng(code, body)
	writeFile("webmats/" .. SHA1(body) .. ".png", body)
end

function Download(uri)
	local ext = uri:Right(4)

	if ext == ".jpg" or uri:Right(5) == ".jpeg" then
		HTTP({
			failed = ErrorNoHalt,
			success = successjpeg,
			method = "GET",
			url = uri
		})
	elseif ext == ".png" then
		HTTP({
			failed = ErrorNoHalt,
			success = successpng,
			method = "GET",
			url = uri
		})
	else
		error("Invalid URI entered for webmat.Download!")
	end
end