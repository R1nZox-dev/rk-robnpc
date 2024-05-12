local QBCore = exports['qb-core']:GetCoreObject()
local waited = true
local Pedrobed = nil 

local function blacklistped(ped)
    for i=1, #Config.peds do
        if Config.peds[i] == ped then
            return true
        end
    end
    return false
end
RegisterNetEvent('rk-robnpc:client:robnpc', function()
    local coords = GetEntityCoords(PlayerPedId())
    local PlayerPed = PlayerPedId()
    local PlayerPeds = {}
    local armed = IsPedArmed(PlayerPed, 4)
    if next(PlayerPeds) == nil then
        for _, player in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(player)
            PlayerPeds[#PlayerPeds + 1] = ped
        end
    end
    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
    if closestDistance < Config.MinDistance and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed, false) then
        if DoesEntityExist(closestPed) and IsEntityAPed(closestPed) then
            if IsPedDeadOrDying(closestPed, true) then
                QBCore.Functions.Notify("droped every thing befor dying", 'error')
            else
                if not armed then
                    QBCore.Functions.Notify("not scared from you i'll call police ", 'error')
                else
                    if waited then
                        ClearPedTasksImmediately(closestPed)
                        local pedhash = GetEntityModel(closestPed)
                        if Pedrobed == pedhash then
                            QBCore.Functions.Notify("you don't remember u already robbed me", 'error')
                        else
                            local bped = blacklistped(pedhash)
                            if not bped then
                                ExcuteRobbing(closestPed)
                                Pedrobed = pedhash
                            else
                                SetCombat(closestPed)
                            end
                        end
                    else
                        QBCore.Functions.Notify("u should wait at least " .. Config.Couldown .. " second", 'error')
                    end
                end
            end
        end
    else
        QBCore.Functions.Notify("littel bit closser it's too far", 'error')
    end
end)

function ExcuteRobbing(closestPed)
    Citizen.CreateThread(function()
    Citizen.Wait(100)
    local PlayerPed = PlayerPedId()
    local dict = 'random@mugging3'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    exports['ps-dispatch']:Robnpc()
    QBCore.Functions.Progressbar("robing", "robbing", Config.RobAnimationSeconds, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = false
    }, {
        animDict = "random@shop_robbery",
        anim = "robbery_action_b",
        flags = 16
    }, {}, {}, function()
    end)
    TaskStandStill(closestPed, Config.RobAnimationSeconds)
    FreezeEntityPosition(closestPed, true)
    TaskPlayAnim(closestPed, dict, 'handsup_standing_base', 8.0, -8, .01, 49, 0, 0, 0, 0)
    Citizen.Wait(Config.RobAnimationSeconds)
    local success = math.random(1, 100)
    print(success)
    if success <= Config.chance then
        QBCore.Functions.TriggerCallback('rk-robnpc:server:giveMoney', function(amount)
            FreezeEntityPosition(closestPed, false)
            QBCore.Functions.Notify("You have robbed: " .. amount .. "$", 'success')
        end)
        TriggerServerEvent('rk-robnpc:server:randomitems')
        ClearPedTasksImmediately(closestPed)
        TaskSmartFleePed(closestPed, PlayerPed, 600.0, -1)
        waited = false
        if Config.ShouldWaitBetweenRobbing then
            Citizen.Wait(Config.Couldown * 1000)
            waited = true
        else
            waited = true
        end
    else
        QBCore.Functions.Notify("Failed the citizen have nothing", 'error')
        FreezeEntityPosition(closestPed, false)
        ClearPedTasksImmediately(closestPed)
        TaskSmartFleePed(closestPed, PlayerPed, 600.0, -1)
        return
    end
end)

end
function SetCombat(closestPed)
    local PlayerPed = PlayerPedId()
            ClearPedTasksImmediately(closestPed)
            GiveWeaponToPed(closestPed,'WEAPON_COMBATPISTOL', 250, false, true)
            SetPedCombatAttributes(closestPed, 0, true)
            SetPedCombatAttributes(closestPed, 5, true)
            SetPedCombatAbility(closestPed, 0)
            SetPedCombatMovement(closestPed, 2)
            SetPedCombatRange(closestPed, 1)
            SetPedKeepTask(closestPed, true)
            TaskCombatPed(closestPed, PlayerPed, 0, 16)
end

-- IF YOU WANT TO TEST THE COMBAT uncomment this bellow and tp to the coords

-- Citizen.CreateThread(function ()
--     local coords = vector4(313.14, -1991.17, 21.91, 58.43)
--     local hash = 's_m_m_armoured_02'
--     local hash2 = 'a_m_y_mexthug_01'
--     RequestModel(hash)
--     while not HasModelLoaded(hash) do
--         Wait(10)
--     end
--     RequestModel(hash2)
--     while not HasModelLoaded(hash) do
--         Wait(10)
--     end
--     local ped1 = CreatePed(1,hash,coords.x,coords.y,coords.z-1,coords.w,0,0)
--     local ped2 = CreatePed(1,hash2,coords.x,coords.y+5,coords.z-1,coords.w,0,0)

-- end)

