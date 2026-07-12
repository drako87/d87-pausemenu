local isOpen = false
local Framework = nil
local streamerMode = false
local fpsBoostActive = false
local ignoreBlockThisFrame = false

function OpenPauseMenu()
    TriggerServerEvent('d87-pausemenu:server:requestAllData')
end

-- Comprueba si en este momento está permitido abrir el menú de pausa.
-- Evita que se abra encima del inventario, tiendas, u otros menús NUI/nativos.
function CanOpenPauseMenu()
    if isOpen then return false end
    if IsPauseMenuActive() then return false end

    if Config.BlockOpenIfNuiFocused and IsNuiFocused() then
        return false
    end

    if Config.BlockOpenIfDead then
        local ped = PlayerPedId()
        if IsEntityDead(ped) or IsPedFatallyInjured(ped) then
            return false
        end
    end

    return true
end

RegisterNetEvent('d87-pausemenu:client:receiveAllData', function(stats)
    isOpen = true
    
    -- Inyección de los bloques de anuncios
    stats.announcementTitle = Config.Announcements.title
    stats.announcementDesc = Config.Announcements.description
    stats.announcement01Title = Config.Announcements01.title
    stats.announcement01Desc = Config.Announcements01.description
    stats.announcement02Title = Config.Announcements02.title
    stats.announcement02Desc = Config.Announcements02.description
    
    -- Inyección de fondos dinámicos del Config hacia la interfaz
    stats.backgrounds = Config.CardBackgrounds
    stats.locales = Config.Locales

    SendNUIMessage({
        action = "open",
        data = stats
    })
    SetNuiFocus(true, true)
end)

function ClosePauseMenu()
    isOpen = false
    SendNUIMessage({ action = "close" })
    SetNuiFocus(false, false)
end

CreateThread(function()
    while true do
        if not ignoreBlockThisFrame then
            DisableFrontendThisFrame()
            
            if IsDisabledControlJustPressed(0, 200) and CanOpenPauseMenu() then
                OpenPauseMenu()
            end
            
            if IsControlJustPressed(0, 199) and not isOpen and not IsNuiFocused() then
                ignoreBlockThisFrame = true
                Wait(10)
                ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), false, -1)
            end
        else
            if not IsPauseMenuActive() then
                ignoreBlockThisFrame = false
            end
        end

        if isOpen then 
            DisableAllControlActions(0)
        end
        Wait(0)
    end
end)

RegisterNUICallback('close', function(data, cb)
    ClosePauseMenu()
    cb('ok')
end)

RegisterNUICallback('action', function(data, cb)
    if data.type ~= "toggle" and data.type ~= "unstuck" then
        ClosePauseMenu()
    end
    
    if data.type == "map" then
        ignoreBlockThisFrame = true
        Wait(15)
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), false, -1)
    elseif data.type == "settings" then
        ignoreBlockThisFrame = true
        Wait(15)
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), false, -1)
    elseif data.type == "rules" then
        TriggerEvent('chat:addMessage', { args = { '^1SISTEMA', 'Abriendo normativas: ' .. Config.Links.rules } })
    elseif data.type == "report" then
        TriggerEvent('chat:addMessage', { args = { '^1REPORTES', 'Usa el comando /report para enviar un ticket.' } })
    elseif data.type == "disconnect" then
        ClosePauseMenu()
        Wait(50)
        SetEntityAsMissionEntity(PlayerPedId(), true, true)
        DeleteEntity(PlayerPedId())
        TriggerServerEvent('d87-pausemenu:server:kickSelf')
    elseif data.type == "link" then
        TriggerEvent('chat:addMessage', { args = { '^1SISTEMA', 'Abriendo enlace: ' .. Config.Links[data.name] } })
    elseif data.type == "unstuck" then
        local ped = PlayerPedId()
        ClearPedTasksImmediately(ped)
        local pos = GetEntityCoords(ped)
        SetEntityCoords(ped, pos.x, pos.y, pos.z + 1.0, false, false, false, true)
        ClosePauseMenu()
    elseif data.type == "toggle" then
        if data.name == "streamer" then
            streamerMode = not streamerMode
            cb({ status = streamerMode })
            return
        elseif data.name == "fps" then
            fpsBoostActive = not fpsBoostActive
            if fpsBoostActive then
                SetTimecycleModifier("gta_graphics")
                RopeDrawShadowEnabled(false)
                CascadeShadowsClearShadowSampleType()
                CascadeShadowsSetAircraftMode(false)
            else
                ClearTimecycleModifier()
                RopeDrawShadowEnabled(true)
            end
            cb({ status = fpsBoostActive })
            return
        end
    end
    cb('ok')
end)
