local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-policegarage:server:SaveVehicle', function(plate, veh, vehname)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    local license = Player.PlayerData.license

    MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        license,
        cid,
        vehname,
        GetHashKey(veh),
        '{}',
        plate,
        0
    })
end)

RegisterNetEvent('qb-policegarge:server:PayForVehicle', function(price)
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.RemoveMoney(Config.paywith, price)
end)

QBCore.Functions.CreateCallback('qb-policegarge:server:GetPlayerMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local PlayerBank = Player.Functions.GetMoney(Config.paywith)
    
    cb(PlayerBank)
end)