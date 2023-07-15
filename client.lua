local QBCore = exports['qb-core']:GetCoreObject()

local donuyomu = false

local yerde = false

local sise = nil

local rastgelesayi = math.random(Config.RandomTime1, Config.RandomTime2)

local GetGroundCoords = function(coords)
  local rayCast               = StartShapeTestRay(coords.x, coords.y, coords.z, coords.x, coords.y, -10000.0, 1, 0)
  local _, hit, hitCoords     = GetShapeTestResult(rayCast)
  return (hit == 1 and hitCoords) or coords
end


RegisterNetEvent("siseyidondur", function()
  print(yerde)
  print(donuyomu)
    if not yerde then
      if not donuyo then
      TriggerServerEvent("torpak-tod:itemsil")
        print("sa")
          local groundCoords = GetGroundCoords(GetEntityCoords(PlayerPedId()))
          print(groundCoords)
          sise = CreateObject(GetHashKey("prop_amb_beer_bottle"), groundCoords.x, groundCoords.y, groundCoords.z, true, true, true)
          print(GetEntityCoords(sise))
          NetworkSetObjectForceStaticBlend(sise, true)
          FreezeEntityPosition(sise, true)
          Wait(10)
          SetEntityRotation(sise, GetEntityRotation(sise).x+90, GetEntityRotation(sise).y+2, GetEntityRotation(sise).z+2, 2, 1)
          Wait(100)
          local sisehead = GetEntityHeading(sise)
          SetEntityRotation(sise, GetEntityRotation(sise).x+10, GetEntityRotation(sise).y+10, GetEntityRotation(sise).z+2, 2, 1)
          yerde = true
          donuyomu = false
          QBCore.Functions.RequestAnimDict("pickup_object")
          TaskPlayAnim(PlayerPedId(), "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false)
          Wait(2000)
          ClearPedTasks(PlayerPedId())
          print("sa")
          Wait(1000)
          print(rastgelesayi)
          ExecuteCommand("Şişeyi Döndürür")
          donuyomu = true 
          Wait(rastgelesayi)
          donuyomu = false
          print(yerde)
          print(GetEntityCoords(sise))
        else
          QBCore.Functions.Notify("Şişe Dönerken Bunu Yapamazsın", "error", 6000)
        end
      else
      donuyomu = true
      Wait(rastgelesayi)
      donuyomu = false
    end


    
  
  
  
  
  exports['qb-target']:AddBoxZone("siseyial", vector3(GetEntityCoords(sise).x,GetEntityCoords(sise).y, GetEntityCoords(sise).z), 0.45, 0.35, {
      name = "siseyial",
      heading = 11.0,
      debugPoly = false,
      minZ = GetEntityCoords(sise).z-1,
      maxZ = GetEntityCoords(sise).z+1,
    }, {
      options = {
        {
                type = "client",
                event = "sisealkanks",
          icon = "fas fa-wine-bottle",
          label = "Şişeyi Al",
        },
        {
          type = "client",
          event = "siseyidondur",
           icon = "fas fa-sync-alt",
          label = "Tekrar Çevir",
      },
      },
      distance = 2.5
    })


end)

RegisterCommand("dondur", function(source, args)
  donuyomu = true 
  Wait(args[1])
  print(args[1])
  donuyomu = false 
end)


CreateThread(function()
  while true do 
    if donuyomu then
    local sisehead = GetEntityHeading(sise)
    SetEntityRotation(sise, GetEntityRotation(sise).x, GetEntityRotation(sise).y+10, GetEntityRotation(sise).z, 2, 1)
    end
    Wait(1)
  end
end)

RegisterNetEvent("sisealkanks", function()
  if not donuyomu then
    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(sise)) < 2.5 then
      DeleteObject(sise)
      TriggerServerEvent("torpak-tod:itemver")
      TaskPlayAnim(PlayerPedId(), "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false)
      Wait(2000)
      ClearPedTasks(PlayerPedId())
      donuyomu = false
      yerde = false
      Wait(100)

      exports['qb-target']:AddBoxZone("siseyial", vector3(0, 0, 0), 0.45, 0.35, {
        name = "siseyial",
        heading = 11.0,
        debugPoly = false,
        minZ = GetEntityCoords(sise).z-1,
        maxZ = GetEntityCoords(sise).z+1,
      }, {
        options = {
          {
                  type = "client",
                  event = "sisealkanks",
            icon = "fas fa-wine-bottle",
            label = "Şişeyi Al",
          },
          {
            type = "client",
            event = "siseyidondur",
             icon = "fas fa-sync-alt",
            label = "Tekrar Çevir",
        },
        },
        distance = 2.5
      })

    end
  else
    QBCore.Functions.Notify("Şişe Dönerken Alamazsın", "error", 6000)
  end
end)