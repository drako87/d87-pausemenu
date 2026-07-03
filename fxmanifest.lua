fx_version 'cerulean'
game 'gta5'

author 'Drako87/Dracatt'
description 'Menu de Pausa Premium Local Multiframework'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
    'config.lua'
}

client_scripts {
    'cl_pause.lua'
}

server_scripts {
    'sv_pause.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    -- Archivos de iconos locales (Evita errores MIME de Cloudflare)
    'html/fontawesome/all.min.css',
    'html/fontawesome/webfonts/fa-solid-900.woff2',
    'html/fontawesome/webfonts/fa-brands-400.woff2'
}
