# TIME (REALTIME) AND WEATHER SYNC
*SYNCRONISIERE DAS WETTER UND DIE ZEIT(Nach Zeitzone: BERLIN +01:00) FÜR ALLE SPIELER AUF DEM SERVER!*

---


![Letzer Commit](https://img.shields.io/github/last-commit/son1c56/fivem-sync-weater-time?label=last%20commit)
![Language](https://img.shields.io/github/languages/top/son1c56/fivem-sync-weater-time?color=blue&label=lua)
![Language Count](https://img.shields.io/github/languages/count/son1c56/fivem-sync-weater-time)

![Markdown](https://img.shields.io/badge/Markdown-000000?style=flat&logo=markdown&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)


---


**ÜBERSICHT**
PLAYER-KILLNOTIFY gibt deinen Spielern eine kurze Übersicht von ihren Kills & Toden.
Basierend auf dem ESX-Legacy Framework für FiveM, sendet es die Notify direkt wenn der Kill/Tod geschehen ist!

- ⌛ **WETTER ÄNDERUNGEN:** Es gibt ein festes Wetter und jede 60 Minuten wird das Wetter zufällig neu kalkuliert!
- 🌐 **ADMIN COMMNAND (/setweather TYPE):** Mit dem Command: "/setweather TYPE" können Administratoren das Wetter für 30 Minuten auf jeden beliebigen GTA Wetter Type ändern!, danach wird es wieder neu kalkuliert!
- 🔑 **SICHERHEIT** Wenn der Playergroup ACE in den SERVER.CFG eingetragen ist, nur dann können die Administratoren den Command nutzen!
- ⚙️ **PERFORMANCE:** Idle: 0.00ms - Wenn abgefragt: 0.00ms - 0.04ms

**ERFORDERLICH**
Füge ```add_ace group.admin weather.set allow``` in in deine SERVER.CFG ein und starte den SERVER neu wenn dass Skript geladen hat könne die Administratoren aus der Group(in unserem Fall "admin") den Command usen!
