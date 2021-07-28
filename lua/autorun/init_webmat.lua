if file.Exists("webmats/", "DATA") then
	for k, v in pairs(file.Find("webmats/*", "DATA")) do
		file.Delete("webmats/" .. v)
	end

	file.Delete("webmats/")
end

file.CreateDir("webmats")
AddCSLuaFile("modules/webmat.lua")
include("modules/webmat.lua")

function WebMaterial(uri, png)
	local str
	-- I despise callbacks so much
	webmat.Download(uri, function(img)
		str = img
	end)

	if str ~= nil then return Material("../data/webmats/" .. str, png) end
end

hook.Add("ShutDown", "RemoveWebMats", function()
	if file.Exists("webmats/", "DATA") then
		for k, v in pairs(file.Find("webmats/*", "DATA")) do
			file.Delete("webmats/" .. v)
		end

		file.Delete("webmats/")
	end
end)
