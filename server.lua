-- from https://ndframework.gitbook.io/nd-framework/developers/server

if Config.UseND then
	NDCore = exports["ND_Core"]:GetCoreObject()
	RegisterServerEvent('pay')
	AddEventHandler('pay', function(price)
		local player = source 
		NDCore.Functions.DeductMoney(price, player, "bank")
	end)
end
