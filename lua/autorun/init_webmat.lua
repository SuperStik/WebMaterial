if file.Exists("webmats/", "DATA") then
	for k, v in pairs(file.Find("webmats/*", "DATA")) do
		file.Delete("webmats/" .. v)
	end

	file.Delete("webmats/")
end

file.CreateDir("webmats")
AddCSLuaFile("modules/webmat.lua")
include("modules/webmat.lua")

hook.Add("ShutDown", function()
	if file.Exists("webmats/", "DATA") then
		for k, v in pairs(file.Find("webmats/*", "DATA")) do
			file.Delete("webmats/" .. v)
		end

		file.Delete("webmats/")
	end
end)
