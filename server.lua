-- from https://ndframework.gitbook.io/nd-framework/developers/server

if config.UseND then
	NDCore = exports["ND_Core"]:GetCoreObject()
	RegisterServerEvent('pay')
	AddEventHandler('pay', function(price)
		local player = source 
		NDCore.Functions.DeductMoney(price, player, "bank")
	end)
end

function versionChecker(expectedResourceName, resourceName, downloadLink, rawGithubLink)
    if expectedResourceName ~= resourceName then
        print("^1[^4" .. expectedResourceName .. "^1] WARNING^0")
        print("Change the resource name to ^4" .. expectedResourceName .. " ^0or else it won't work properly!")
        StopResource(resourceName)
        return
    end
    PerformHttpRequest(rawGithubLink, function(errorCode, resultData, resultHeaders)
        local i, j = string.find(tostring(resultData), "version")
        local resultData = string.sub(tostring(resultData), i, j + 12)
        local resultData = string.gsub(resultData, "version \"", "")
        local i, j = string.find(resultData, "\"")
        local resultData = string.sub(resultData, 1, i - 1)
        local githubVersion = string.gsub(resultData, "%.", "")
        local fileVersion = string.gsub(GetResourceMetadata(expectedResourceName, "version", 0), "%.", "")
        local githubVersion = tonumber(githubVersion)
        local fileVersion = tonumber(fileVersion)

        if not githubVersion and not fileVersion then
            print("^1[^4" .. expectedResourceName .. "^1] WARNING^0")
            print("You may not have the latest version of ^4" .. expectedResourceName .. "^0. A newer, improved version may be present at ^5" .. downloadLink .. "^0")
        elseif githubVersion > fileVersion then
            local oldVersion = string.sub(fileVersion, 1, 1) .. "." .. string.sub(fileVersion, 2, 2) .. "." .. string.sub(fileVersion, 3, 3)
            local newVersion = string.sub(githubVersion, 1, 1) .. "." .. string.sub(githubVersion, 2, 2) .. "." .. string.sub(githubVersion, 3, 3)
            print("^1[^4" .. expectedResourceName .. "^1] WARNING^0")
            print("^4" .. expectedResourceName .. " ^0is outdated. Please update it from ^5" .. downloadLink .. " ^0| Current Version: ^1" .. oldVersion .. " ^0| New Version: ^2" .. newVersion .. " ^0|")
        elseif githubVersion < fileVersion then
            local oldVersion = string.sub(fileVersion, 1, 1) .. "." .. string.sub(fileVersion, 2, 2) .. "." .. string.sub(fileVersion, 3, 3)
            local newVersion = string.sub(githubVersion, 1, 1) .. "." .. string.sub(githubVersion, 2, 2) .. "." .. string.sub(githubVersion, 3, 3)
            print("^1[^4" .. expectedResourceName .. "^1] WARNING^0")
            print("^4" .. expectedResourceName .. " ^0version number is higher than expected | Current Version: ^3" .. oldVersion .. " ^0| Expected Version: ^2" .. newVersion .. " ^0|")
        else
            local newVersion = string.sub(githubVersion, 1, 1) .. "." .. string.sub(githubVersion, 2, 2) .. "." .. string.sub(githubVersion, 3, 3)
            print("^4" .. expectedResourceName .. " ^0is up to date | Current Version: ^2" .. newVersion .. " ^0|")
        end
    end)
end

versionChecker("ND_Core", GetCurrentResourceName(), "https://github.com/ItzEndah/HealingPads", "https://raw.githubusercontent.com/ItzEndah/HealingPads/main/fxmanifest.lua")