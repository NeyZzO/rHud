local toggled = true

MinimapScaleform = {
    scaleform = nil,
}

local health, armor, hunger, thirst = 0,0,0,0
local nuiLoaded = false

Citizen.CreateThread(function()
    MinimapScaleform.scaleform = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

RegisterNUICallback('hudLoaded', function(data, cb)
    nuiLoaded = true
    local plyState = Player(-1).state.proximity.index
    cb({voiceState = Player(-1).state.proximity.index})
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        HideHudComponentThisFrame(1)  -- Wanted Stars
        HideHudComponentThisFrame(2)  -- Weapon Icon
        HideHudComponentThisFrame(3)  -- Cash
        HideHudComponentThisFrame(4)  -- MP Cash
        HideHudComponentThisFrame(6)  -- Vehicle Name
        HideHudComponentThisFrame(7)  -- Area Name
        HideHudComponentThisFrame(8)  -- Vehicle Class
        HideHudComponentThisFrame(9)  -- Street Name
        HideHudComponentThisFrame(13) -- Cash Change
        HideHudComponentThisFrame(17) -- Save Game
        HideHudComponentThisFrame(20) -- Weapons stats
    end
end)

Citizen.CreateThread(function()
    while true do
        if nuiLoaded then
            local hl = GetEntityHealth(PlayerPedId())
            SendNUIMessage({type= 'sethealth', value= hl})

            local ar = GetPedArmour(PlayerPedId())
            if ar ~= armor then
                armor = ar
                SendNUIMessage({type= 'setarmor', value= ar})
            end
        end
        Citizen.Wait(10)
    end
end)

CreateThread(function()
    while true do
        if nuiLoaded then
            TriggerEvent('esx_status:getStatus', 'hunger', function(status)
                hunger = status.val
                SendNUIMessage({type="sethunger", value=hunger / 10000})
            end)

            TriggerEvent('esx_status:getStatus', 'thirst', function(status)
                thirst = status.val
                SendNUIMessage({type="setthirst", value=thirst / 10000})
            end)

        end
        Citizen.Wait(2000)
    end
end)


local oxygen = 40
CreateThread(function()
    while true do
        if IsPedSwimmingUnderWater(PlayerPedId()) then
            oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId())
            SendNUIMessage({type="setoxygen", value=oxygen})
        end
        if oxygen < 40.0 and not IsPedSwimmingUnderWater(PlayerPedId()) then
            oxygen += 1
            SendNUIMessage({type="setoxygen", value=oxygen})
        end
        Citizen.Wait(5)
    end
end)

AddEventHandler('pma-voice:setTalkingMode', function(newTalkingRange)
    SendNUIMessage({type="voicerange", value=newTalkingRange})
end)


CreateThread(function()
    local talking = false
    while true do
        if NetworkIsPlayerTalking(PlayerId()) and talking == false then
            SendNUIMessage({type="talking", value= true})
            talking = true
        elseif not NetworkIsPlayerTalking(PlayerId()) and talking == true then
            SendNUIMessage({type="talking", value= false})
            talking = false
        end
        Citizen.Wait(5)
    end
end)

RegisterNetEvent('rHud:toggle')
AddEventHandler('rHud:toggle', function(bool)
    toggled = bool
    SendNUIMessage({type="toggle", value=toggled})
end)