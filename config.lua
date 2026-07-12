Config = {}
Config.Framework = "qbx" -- Opciones compatibles: "esx", "qb-core", "qbx"

Config.Locales = {
    map = "MAPA",
    settings = "AJUSTES",
    rules = "NORMATIVAS",
    report = "REPORTAR",
    disconnect = "SALIR",
    battlepass = "BATTLEPASS",
    news = "NOTICIAS",
    unstick = "DESBUGUEAR",
    fps = "FPS BOOST",
    streamer = "MODO STREAMER",
    bills = "FACTURAS Y MULTAS",
    billsPending = "PENDIENTES"
}

Config.Links = {
    web = "https://tu-web.com",
    discord = "https://discord.gg",
    rules = "https://tu-web.com",
    store = "https://tu-servidor.com",
    news = "https://tu-web.com"
}

-- CONFIGURACIÓN DE IMÁGENES DE FONDO DE LAS TARJETAS
-- Ahora las imágenes se cargan LOCALMENTE desde la carpeta html/img/
-- Coloca tus archivos ahí con estos mismos nombres (o cambia las rutas de abajo).
-- Formatos recomendados: .png o .jpg, tamaño sugerido 500x300px aprox.
Config.CardBackgrounds = {
    map = "img/map.png",
    settings = "img/settings.png",
    rules = "img/rules.png",
    report = "img/report.png",
    battlepass = "img/battlepass.png"
}

-- Los 3 bloques de anuncios independientes
Config.Announcements = {
    title = "ANUNCIOS GENERALES",
    description = "¡Novedades semanales! Optimizaciones de red completadas y eventos activos de rol el próximo fin de semana."
}

Config.Announcements01 = {
    title = "NOTAS DEL PARCHE",
    description = "Se han corregido los errores de sincronización con los saldos bancarios y se optimizó el menú de pausa a 0.00 ms."
}

Config.Announcements02 = {
    title = "NORMATIVA DESTACADA",
    description = "Recuerda que está totalmente prohibido el comportamiento anti-rol en zonas seguras. Revisa el canal de normativas."
}

-- CONFIGURACIÓN DEL BLOQUEO DE APERTURA
-- Evita que el menú de pausa se abra encima de inventarios u otros menús NUI activos.
Config.BlockOpenIfNuiFocused = true -- Bloquea si CUALQUIER otro NUI (inventario, tienda, etc.) tiene el foco
Config.BlockOpenIfDead = true       -- Bloquea si el jugador está muerto/inconsciente

-- CONFIGURACIÓN DEL SISTEMA DE FACTURAS Y MULTAS
-- Este script NO trae un sistema de facturación propio: debes conectarlo con el que uses
-- en tu servidor (qb-billing, ps-billing, renewed-banking, okokBilling, etc).
-- Edita la función GetPlayerBills() en sv_pause.lua para devolver los datos reales.
