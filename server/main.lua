local QBCore = exports['qb-core']:GetCoreObject()
local src = source
QBCore.Functions.CreateCallback('rk-robnpc:server:giveMoney', function(source, callback)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local money = math.random(Config.MinMoney, Config.MaxMoney)
    Player.Functions.AddMoney('cash', money)
    callback(money)
end)
RegisterNetEvent('rk-robnpc:server:randomitems',function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local filteredItems = {}
	for k, v in pairs(Config.items) do
			filteredItems[#filteredItems+1] = v
	end
	for _ = 1, Config.MaxAmount, 1 do
		local randitem = filteredItems[math.random(1, #filteredItems)]
        print(randitem.name )
		local amount = 1
        if Player then
		    Player.Functions.AddItem(randitem.name, amount) 
			TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items[randitem.name], 'add')
            Wait(500)
        end
	end
end)