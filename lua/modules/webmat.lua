local HTTP = HTTP
local SHA1 = util.SHA1
local writeFile = file.Write
local ErrorNoHalt = ErrorNoHalt
local error = error
module("webmat")

function Download(uri)
	local ext = uri:Right(4)

	if ext == ".jpg" or uri:Right(5) == ".jpeg" then
		local str

		if HTTP({
			failed = ErrorNoHalt,
			success = function(code, body)
				str = SHA1(body) .. ".jpg"
				writeFile("webmats/" .. str, body)
			end,
			method = "GET",
			url = uri
		}) then
			return str
		end
	elseif ext == ".png" then
		local str

		if HTTP({
			failed = ErrorNoHalt,
			success = function(code, body)
				str = SHA1(body) .. ".png"
				writeFile("webmats/" .. str, body)
			end,
			method = "GET",
			url = uri
		}) then
			return str
		end
	else
		error("Invalid URI entered for webmat.Download!")
	end
end
