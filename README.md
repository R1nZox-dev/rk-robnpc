# NPC Rob
it may have some Uncertain codes cause its my second script but Surely no error no bugs full optimized
- [note] : i don't Authorise selling the script don't be trash  
- if u have any [issue](https://github.com/R1nZox-dev/rk-robnpc/issues) pull it right here and i'll try to respond soon as possible 
# Featurs
* robbing a citizen (NPCs)
* configurable and open source
* chance to have nothing on pockets 
* police alerts 
* possible gunfight with certin peds (configurable)
* couldown Between robbery 
* random items and the amount of total items given configurable 
* must be armed else the citizen (npc) won't be scared 
```lua
Config = {}

Config.ShouldWaitBetweenRobbing = false -- if the player should wait Between robing 
Config.Couldown = 60 -- the couldown Between 2 robbery if Config.ShouldWaitBetweenRobbing = false  no need to set it 
Config.MinDistance = 5 -- the disctence Between the player and the npc to excute to robbry 

Config.RobAnimationSeconds = 10000 -- 1000 = 1 second  | basicly means the time of robbing 
Config.chance = 70 --- 10 = 10% chance to execute the robbey
Config.MinMoney = 100 -- min money to give
Config.MaxMoney = 500 -- max money to give
Config.peds = { -- soo here you'll need to put the peds model not the hash key and to get that u will need to have a dev tool to get entity models if the ped model is set here it will excute a gun fight beetwen the ped and the player
    1669696074,
    810804565,
}
Config.MaxAmount = 5 -- total amount of the given items
Config.items = { -- 
lockpick = { name = 'lockpick' },
trojan_usb = { name = 'trojan_usb'}
-- name of the item  = { name = 'and here put the spawn name'} ---if you want too another items do it like that unlimited
}
```
* money to give randomly 

[Discord](https://discord.gg/ZKqYYAQGCb)
## Preview 
[PedCombat](https://streamable.com/f8bjcm)
[robbing-alert-fleetask](https://streamable.com/j2lklm)
[couldown](https://streamable.com/2nkslw)
# Depedency
1. [qb-core](https://github.com/qbcore-framework/qb-core)
2. [qb-radialmenu](https://github.com/qbcore-framework/qb-radialmenu)
3. [ps-dipatch](https://github.com/Project-Sloth/ps-dispatch) FOR THE ALERTS
# Installation
* Download ZIP
* drag and drop the resource into your server files 
*  Configure ON [config.lua](https://github.com/R1nZox-dev/rk-robnpc/blob/main/config.lua)
* add this function into `alerts.lua` in your ps dispatch 
```lua
 local function Robnpc()
    local coords = GetEntityCoords(cache.ped)

    local dispatchData = {
        message = locale('npcrob'),
        codeName = '911call',
        code = '10-',
        icon = 'fas fa-user',
        priority = 3,
        coords = coords,
        gender = GetPlayerGender(),
        street = GetStreetAndZone(coords),
        information = "An armed criminal threading citizens",
        alertTime = 3,
        jobs = { 'leo' }
    }

    TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
end
exports('Robnpc', Robnpc)
```
* CHANGE notification name on client > main.lua sorry my english is soo bad 
* next add this into your radial menu script qb-radialmenu > config.lua  line 42 
```lua
{
                id = 'robnpc',
                title = 'Rob Citizen',
                icon = 'mask',
                type = 'client',
                event = 'rk-robnpc:client:robnpc',
                shouldClose = true
            },
```
like that 
[image](https://github.com/R1nZox-dev/rk-robnpc/blob/main/img.png)
* do not change the folder name or the events name it will cause u some error if u are not a good dev 
