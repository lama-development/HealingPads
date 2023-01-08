-- from https://ndframework.gitbook.io/nd-framework/developers/server
if Config.UseND then
	NDCore = exports["ND_Core"]:GetCoreObject()
	RegisterServerEvent('pay')
	AddEventHandler('pay', function(price)
		local player = source 
		NDCore.Functions.DeductMoney(price, player, "bank")
	end)
end

-- version checker
Citizen.CreateThread( function()
	updatePath = "/lama-development/HealingPads"
	resourceName = "HealingPads by Lama"
	
	function checkVersion(err, responseText, headers)
		-- Returns the version set in the file
		curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")

		if responseText == nil or curVersion == nil then
			print("^1There was an error retrieving the version of " .. resourceName .. ": the version checker will be skipped.")
		else if tonumber(curVersion) == tonumber(responseText) then
			print("^2" .. resourceName .." is up to date. Enjoy.")
		else 
			print("^1" .. resourceName .. " is outdated.\nLatest version: " .. responseText .. "Current version: " .. curVersion .. "\nPlease update it from: https://github.com" .. updatePath)
		end
	end
end
	
	PerformHttpRequest("https://raw.githubusercontent.com" .. updatePath .. "/main/version", checkVersion, "GET")
end)
