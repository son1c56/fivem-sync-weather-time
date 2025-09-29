local currentWeather = "EXTRASUNNY"
local hour, minute, second = 12, 0, 0

RegisterNetEvent("timeweather:sync")
AddEventHandler("timeweather:sync", function(h, m, s, weather)
    hour, minute, second = h, m, s

    if currentWeather ~= weather then
        currentWeather = weather
        ClearWeatherTypePersist()
        SetWeatherTypePersist(currentWeather)
        SetWeatherTypeNow(currentWeather)
        SetWeatherTypeNowPersist(currentWeather)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1200) -- jeden Frame
        NetworkOverrideClockTime(hour, minute, second)

        SetWeatherTypePersist(currentWeather)
        SetWeatherTypeNow(currentWeather)
        SetWeatherTypeNowPersist(currentWeather)
    end
end)
