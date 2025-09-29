local currentWeather = "EXTRASUNNY"
local lastWeatherChange = os.time()
local adminOverride = false

-- Wetter Wahrscheinlichkeiten
local weatherTypes = {
    {type = "EXTRASUNNY", chance = 40},
    {type = "CLEAR", chance = 20},
    {type = "CLOUDS", chance = 10},
    {type = "OVERCAST", chance = 10},
    {type = "RAIN", chance = 8},
    {type = "THUNDER", chance = 5},
    {type = "FOGGY", chance = 7}
}

-- Zufälliges Wetter
local function getRandomWeather()
    local rnd = math.random(1,100)
    local sum = 0
    for _,w in ipairs(weatherTypes) do
        sum = sum + w.chance
        if rnd <= sum then
            return w.type
        end
    end
    return "CLEAR"
end

-- Echtzeit Funktion
local function getBerlinTime()
    local t = os.date("!*t") -- UTC
    local month,day = t.month,t.day
    local dst = (month > 3 and month < 10) or (month == 3 and day >= 30) or (month == 10 and day < 30)
    local offset = dst and 2 or 1
    local hour = (t.hour + offset) % 24
    return hour, t.min, t.sec
end

-- Sync Funktion
local function syncTimeWeather(target)
    local hour,minute,second = getBerlinTime()
    if target then
        TriggerClientEvent("timeweather:sync", target, hour, minute, second, currentWeather)
    else
        TriggerClientEvent("timeweather:sync", -1, hour, minute, second, currentWeather)
    end
end

-- Sync Loop (alle 30 Sekunden)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30 * 1000)

        local hour,minute,second = getBerlinTime()

        -- Nur wenn kein Admin Override → checke Wetter alle 60 Minuten
        if not adminOverride and (os.time() - lastWeatherChange >= 60*60) then
            currentWeather = getRandomWeather()
            lastWeatherChange = os.time()
        end

        syncTimeWeather()
    end
end)

-- Spieler bekommt sofort Sync beim Join
AddEventHandler("playerJoining", function()
    local src = source
    Citizen.SetTimeout(2000, function() -- kleine Verzögerung bis Spieler geladen ist
        if src and GetPlayerPing(src) > 0 then
            syncTimeWeather(src)
        end
    end)
end)

-- Bei Script Restart → sofort Sync an alle
AddEventHandler("onResourceStart", function(res)
    if res == GetCurrentResourceName() then
        Citizen.SetTimeout(1000, function()
            syncTimeWeather()
        end)
    end
end)

RegisterCommand("setweather", function(source, args)
    if source > 0 and not IsPlayerAceAllowed(source, "weather.set") then
        TriggerClientEvent("chat:addMessage", source, { args = {"System", "Keine Rechte!"}})
        return
    end

    if not args[1] then
        if source > 0 then
            TriggerClientEvent("chat:addMessage", source, { args = {"System", "Usage: /setweather <WEATHER>"}})
        end
        return
    end

    local weather = string.upper(args[1])
    currentWeather = weather
    adminOverride = true
    lastWeatherChange = os.time()
    syncTimeWeather()

    Citizen.SetTimeout(30 * 60 * 1000, function()
        adminOverride = false
    end)

    print(("^1[Wetter]^7: Manuell auf ^5%s^7 gesetzt für 30 Minuten."):format(weather))
    TriggerClientEvent("esx:showNotification", source, "Wetter auf [" ..weather.. "] geändert!", "success", 4000, "SYSTEM - Wetter", "top-left")
    TriggerClientEvent("chat:addMessage", -1, { args = {"^1Wetter^7", "Admin hat das Wetter geändert: "..weather}})

end, false)
