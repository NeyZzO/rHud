
MinimapScaleform = {
    scaleform = nil,
}
hunger, thirst = nil


local function getMinimap()
    return MinimapScaleform.scaleform
end

function SetSatNavDirection(direction)
    local dir = SatNav[direction]
    if type(direction) == 'number' then
        dir = direction
    end
    if dir then
        BeginScaleformMovieMethod(getMinimap(), "SET_SATNAV_DIRECTION")
        ScaleformMovieMethodAddParamInt(dir.icon)
        EndScaleformMovieMethod()
    end
end

function SetSatNavDistance(distance)
    BeginScaleformMovieMethod(getMinimap(), "SET_SATNAV_DISTANCE")
    ScaleformMovieMethodAddParamInt(distance)
    EndScaleformMovieMethod()
end

function SetSatNavState(show)
    BeginScaleformMovieMethod(getMinimap(), (show and "SHOW_SATNAV" or "HIDE_SATNAV"))
    EndScaleformMovieMethod()
end

function SetStallWarningState(show)
    BeginScaleformMovieMethod(getMinimap(), "SHOW_STALL_WARNING")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function SetAbilityGlow(show)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR_GLOW")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function SetAbilityVisible(show)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR_VISIBILITY_IN_MULTIPLAYER")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function ShowYoke(x, y, vis, alpha)
    BeginScaleformMovieMethod(getMinimap(), "SHOW_YOKE")
    ScaleformMovieMethodAddParamFloat(show)
    ScaleformMovieMethodAddParamFloat(show)
    ScaleformMovieMethodAddParamBool(show)
    ScaleformMovieMethodAddParamInt(alpha)
    EndScaleformMovieMethod()
end

function SetHealthArmorType(type)
    BeginScaleformMovieMethod(getMinimap(), "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(type)
    EndScaleformMovieMethod()
end

function SetHealthAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_PLAYER_HEALTH")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamFloat(0)
    ScaleformMovieMethodAddParamFloat(2000)
    ScaleformMovieMethodAddParamBool(false)
    EndScaleformMovieMethod()
end

function SetArmorAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_PLAYER_ARMOUR")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamFloat(0)
    ScaleformMovieMethodAddParamFloat(2000)
    EndScaleformMovieMethod()
end

function SetAbilityAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamFloat(100)
    EndScaleformMovieMethod()
end

function SetAirAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_AIR_BAR")
    ScaleformMovieMethodAddParamFloat(amount)
    EndScaleformMovieMethod()
end

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
        Citizen.Wait(100)
        SendNUIMessage({type= 'sethealth', value= GetEntityHealth(PlayerPedId())})
    end
end)
