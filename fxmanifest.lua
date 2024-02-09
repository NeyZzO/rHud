fx_version 'cerulean'
game 'gta5'
lua54 'yes'

files {
    'web/public/**/*',
    "web/index.html"
}

ui_page 'web/index.html'
shared_scripts {
  '@es_extended/imports.lua',
}
client_script 'client/main.lua'
server_script 'server/main.lua'