local Framework = nil

CreateThread(function()
    if Config.Framework == "qb-core" then
        Framework = exports['qb-core']:GetCoreObject()
    elseif Config.Framework == "esx" then
        Framework = exports['esx_core']:getSharedObject()
    end
end)

function GetServerData()
    local police, ems, mechanic, staff = 0, 0, 0, 0
    local totalPlayers = #GetPlayers()

    if Config.Framework == "qb-core" and Framework then
        local players = Framework.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then police = police + 1 end
            if v.PlayerData.job.name == "ambulance" and v.PlayerData.job.onduty then ems = ems + 1 end
            if v.PlayerData.job.name == "mechanic" and v.PlayerData.job.onduty then mechanic = mechanic + 1 end
            if Framework.Functions.HasPermission(v.PlayerData.source, "admin") then staff = staff + 1 end
        end
    elseif Config.Framework == "esx" and Framework then
        local xPlayers = Framework.GetExtendedPlayers()
        for _, xPlayer in pairs(xPlayers) do
            if xPlayer.job.name == 'police' then police = police + 1 end
            if xPlayer.job.name == 'ambulance' then ems = ems + 1 end
            if xPlayer.job.name == 'mechanic' then mechanic = mechanic + 1 end
            if xPlayer.getGroup() ~= 'user' then staff = staff + 1 end
        end
    end
    return { police = police, ems = ems, mechanic = mechanic, staff = staff, online = totalPlayers }
end

RegisterNetEvent('d87-pausemenu:server:requestAllData', function()
    local src = source
    local sData = GetServerData()
    local data = {
        id = src, cash = 0, bank = 0, job = "Desempleado", charName = "Sin Nombre",
        police = sData.police, ems = sData.ems, mechanic = sData.mechanic, staff = sData.staff, online = sData.online
    }

    if Config.Framework == "qb-core" and Framework then
        local Player = Framework.Functions.GetPlayer(src)
        if Player and Player.PlayerData then
            data.cash = Player.PlayerData.money['cash'] or Player.PlayerData.money['money'] or 0
            data.bank = Player.PlayerData.money['bank'] or 0
            data.job = Player.PlayerData.job.label or "Desempleado"
            data.charName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
            
            if data.cash == 0 and data.bank == 0 then
                local result = MySQL.scalarSync('SELECT money FROM players WHERE citizenid = ?', {Player.PlayerData.citizenid})
                if result then
                    local moneyTable = json.decode(result)
                    if moneyTable then
                        data.cash = moneyTable.cash or 0
                        data.bank = moneyTable.bank or 0
                    end
                end
            end
        end
    elseif Config.Framework == "esx" and Framework then
        local xPlayer = Framework.GetPlayerFromId(src)
        if xPlayer then
            data.cash = xPlayer.getMoney() or 0
            if data.cash == 0 and xPlayer.getAccount('cash') then data.cash = xPlayer.getAccount('cash').money or 0 end
            if data.cash == 0 and xPlayer.getAccount('money') then data.cash = xPlayer.getAccount('money').money or 0 end
            
            local bankAccount = xPlayer.getAccount('bank')
            data.bank = bankAccount and bankAccount.money or 0
            data.job = xPlayer.getJob() and xPlayer.getJob().label or "Desempleado"
            data.charName = xPlayer.getName() or "Sin Nombre"
            
            if data.cash == 0 and data.bank == 0 then
                local result = MySQL.query.await('SELECT accounts FROM users WHERE identifier = ?', {xPlayer.identifier})
                if result and result[1] then
                    local accounts = json.decode(result[1].accounts)
                    if accounts then
                        data.cash = accounts.money or accounts.cash or 0
                        data.bank = accounts.bank or 0
                    end
                end
            end
        end
    end

    TriggerClientEvent('d87-pausemenu:client:receiveAllData', src, data)
end)

RegisterNetEvent('d87-pausemenu:server:kickSelf', function()
    local src = source
    DropPlayer(src, "Te has desconectado voluntariamente del servidor.")
end)
