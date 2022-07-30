-- from https://ndframework.gitbook.io/nd-framework/developers/server

NDCore = exports["ND_Core"]:GetCoreObject()

RegisterServerEvent('pay')
AddEventHandler('pay', function(price)
	local player = source 
	NDCore.Functions.DeductMoney(price, player, "bank")
end)