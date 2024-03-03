fx_version  'cerulean'
game        'gta5'
lua54       'yes'

author      'Phil'
description 'allows players to convert paperbags to player masks and wear them.'

ui_page 'web/index.html'

shared_scripts {
    'config.lua'
}
client_scripts {
    'client/client.lua'
}

export 'putonmmask'

server_scripts {
    'server/server.lua'
}

files {
    'web/*.*',
    'web/images/*.*',
    'web/script/*.*',
    'web/style/*.*',
}
