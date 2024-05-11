Config = {}

Config.ShouldWaitBetweenRobbing = false -- if the player should wait Between robing 
Config.Couldown = 60 -- 60 = 60 second the couldown Between 2 robbery if Config.ShouldWaitBetweenRobbing = false  no need to set it 
Config.MinDistance = 5 -- the disctence Between the player and the npc to excute to robbry 

Config.RobAnimationSeconds = 10000 -- 1000 = 1 second  | basicly means the time of robbing 
Config.chance = 70 --- 70 = 70%
Config.MinMoney = 100 -- min money to give
Config.MaxMoney = 500 -- max money to give
Config.peds = { -- soo here you'll need to put the peds model not the hash key and to get that u will need to have a dev tool to get entity models if the ped model is set here it will excute a gun fight beetwen the ped and the player
    1669696074,
    810804565,
}
Config.MaxAmount = 5 -- max ammount of all the items 
Config.items = { -- 
lockpick = { name = 'lockpick' },
trojan_usb = { name = 'trojan_usb'}
-- name of the item  = { name = 'and here put the spawn name'} ---if you want too another items do it like that unlimited
}