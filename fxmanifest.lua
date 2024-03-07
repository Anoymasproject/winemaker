fx_version 'adamant'
game 'gta5'
description 'winemaker job'
lua54 'yes'
version '1.0.0'

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
    'config.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'client/main.lua'
}

dependencies {
    'ox_lib',
    'ox_inventory',
    'ox_target'
}
