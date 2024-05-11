fx_version "cerulean"
game "gta5"

description 'npc rob for qb core 1.0 '

author 'R1nzox dev'

server_scripts {
     'config.lua',
     'server/main.lua'
}
    
client_scripts {
    'client/main.lua'
}
shared_scripts {
    'config.lua',
}

dependencies {
    'qb-core',
    'ps-dispatch',
    'qb-radialmenu'
}