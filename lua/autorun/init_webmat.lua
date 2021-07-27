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
	Material("../data/webmats/" .. webmat.Download(uri), png)
end

hook.Add("ShutDown", "RemoveWebMats", function()
	if file.Exists("webmats/", "DATA") then
		for k, v in pairs(file.Find("webmats/*", "DATA")) do
			file.Delete("webmats/" .. v)
		end

		file.Delete("webmats/")
	end
end)
