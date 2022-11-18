-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'https://github.com/Arab-Framework-Server'
description 'Police Vehicle Shop'
version '1.0.0'

-- What to run
client_scripts {
    'client/client.lua',
    'config.lua'
}
server_script {
    'server/server.lua',
    'config.lua',
    '@oxmysql/lib/MySQL.lua'
}