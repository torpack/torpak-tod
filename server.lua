local QBCore = exports['qb-core']:GetCoreObject()
local donuyo = false

QBCore.Functions.CreateUseableItem("sise", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("siseyidondur", source)
    end
end)


RegisterNetEvent("torpak-tod:itemver", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem("sise", 1, false)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["sise"], "add", 1)
end)

RegisterNetEvent("torpak-tod:itemsil", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("sise", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["sise"], "remove", 1)
end)


