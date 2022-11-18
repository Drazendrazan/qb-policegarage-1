local QBCore = exports['qb-core']:GetCoreObject()
local isbus = false

local function GetVehicleName(hash)
    for k,v in pairs(QBCore.Shared.Vehicles) do
        if hash == v.hash then
            return v.model
        end
    end
end

local function SpawnVehicle(model, coords, heading)
    QBCore.Functions.LoadModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true)
    local netid = NetworkGetNetworkIdFromEntity(veh)
    local plate = QBCore.Functions.GetPlate(veh)
    local props = QBCore.Functions.GetVehicleProperties(veh)
    local hash = props.model
    local vehname = GetVehicleName(hash)

    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetNetworkIdCanMigrate(netid, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, 'OFF')
    SetVehicleFuelLevel(veh, 100.0)
    SetVehicleModKit(veh, 0)
    SetVehicleDirtLevel(veh, 0)
    SetModelAsNoLongerNeeded(model)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)

    if model == Config.busmodel then
        isbus = true
    elseif isbus == false then
        TriggerServerEvent('qb-policegarage:server:SaveVehicle', plate, veh, vehname)
    end
end

RegisterNetEvent('qb-policegarge:client:VehicleSpawn', function(data)
    QBCore.Functions.TriggerCallback('qb-policegarge:server:GetPlayerMoney', function(PlayerMoney)
        if data.price <= PlayerMoney then
            if QBCore.Functions.SpawnClear(data.coords, data.coordsradius) then
                SpawnVehicle(data.vehicle, data.coords, data.heading, data.isnetworked)
                if isbus == false then
                    TriggerServerEvent('qb-policegarge:server:PayForVehicle', data.price)
                    QBCore.Functions.Notify('You owned this vehicle')
                else
                    QBCore.Functions.Notify('You cant save this bus in your garages', 'error', 5000)
                    isbus = false
                end
            else
                QBCore.Functions.Notify('There Something Blocking', 'error', 5000)
            end
        else
            QBCore.Functions.Notify('You dont have current money', 'error', 4000)
        end
    end)
end)

RegisterNetEvent('qb-policegarge:client:VehicleMenu', function()
    local Vehicles = {}

    Vehicles[#Vehicles + 1] = {
        isMenuHeader = true,
        header = 'Police Vehicles',
        icon = 'fas fa-warehouse'
    }

    for k,v in pairs(Config.Vehicleslist) do
        Vehicles[#Vehicles + 1] = {
            header = v.label,
            txt = '$' .. v.price,
            icon = 'fas fa-car',
            params = {
                event = 'qb-policegarge:client:VehicleSpawn',
                args = {
                    vehicle = k,
                    price = v.price,
                    coords = v.coords,
                    heading = v.heading,
                    coordsradius = v.coordsradius
                }
            }
        }
    end
    exports['qb-menu']:openMenu(Vehicles)
end)

CreateThread(function()
    local model = Config.ped.model
    QBCore.Functions.LoadModel(model)
    local entity = CreatePed(0, model, Config.ped.coords, Config.ped.heading, true, false)
    FreezeEntityPosition(entity, true)

    exports['qb-target']:AddTargetEntity(entity, {
      options = {
        {
          num = 1,
          type = "client",
          event = "qb-policegarge:client:VehicleMenu",
          icon = Config.ped.icon,
          label = Config.ped.label,
          job = Config.ped.job
        }
      },
      distance = Config.ped.distance,
    })
end)
