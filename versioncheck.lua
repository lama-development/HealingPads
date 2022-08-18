Citizen.CreateThread( function()
	updatePath = "/ItzEndah/HealingPads"
	resourceName = "HealingPads by Lama"
	
	function checkVersion(err, responseText, headers)
		-- Returns the version set in the file
		curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")

		if tonumber(curVersion) == tonumber(responseText) then
			print("^2" .. resourceName .." is up to date. Enjoy.")
		else if tonumber(curVersion) < tonumber(responseText) then
			print("^1" .. resourceName .. " is outdated.\nLatest version: " .. responseText .. "Current version: " .. curVersion .. "\nPlease update it from: https://github.com" .. updatePath)
		else
			print("^1" .. resourceName .. ": there was an error retrieving the latest version of the resource from GitHub. The version checker will be skipped.")	
		end
	end
end
	
	PerformHttpRequest("https://raw.githubusercontent.com" .. updatePath .. "/main/version", checkVersion, "GET")
end)
