# d87-pausemenu

Un menú de pausa personalizado, moderno y altamente optimizado para servidores de FiveM. Diseñado mediante una interfaz de cuadrícula (Grid UI) limpia, inspirada en las interfaces de servidores competitivos y completamente adaptable a múltiples entornos de desarrollo (Frameworks).

---

## 🚀 Características (Features)

*   **Multiframework:** Soporte nativo y automático para `ESX`, `QBCore` y `QBox (QBX)`.
*   **Optimización Extrema:** Consume `0.00 ms` en reposo (idle) gracias a un sistema de intervalos variables dinámicos.
*   **Mapeo de Teclas Inteligente:** 
    *   `ESC` abre este menú de pausa personalizado.
    *   `P` abre el menú nativo original de GTA V (evitando conflictos visuales, parpadeos de mapa o errores de escala).
*   **Información en Tiempo Real:** Muestra la ID del jugador, trabajo actual, dinero en efectivo y balance bancario de forma segura desde el servidor.
*   **Fácil Configuración:** Modificación centralizada de traducciones, textos y enlaces de redes sociales desde un único archivo.

---

## 📂 Estructura del Proyecto (Project Structure)

```text
d87-pausemenu/
├── fxmanifest.lua
├── config.lua
├── cl_pause.lua
├── sv_pause.lua
└── html/
    ├── index.html
    ├── style.css
    └── script.js
```

---

## 🛠️ Instalación (Installation)

1. **Descargar el recurso:** Descarga o clona este repositorio dentro de la carpeta `resources` de tu servidor.
   ```bash
   git clone https://github.com
   ```
2. **Configurar el Framework:** Abre el archivo `config.lua` y define el framework que utiliza tu servidor (`esx`, `qb-core` o `qbx`):
   ```lua
   Config.Framework = "qb-core" -- Opciones: "esx", "qb-core", "qbx"
   ```
3. **Asegurar el inicio:** Añade la línea de carga en tu archivo de configuración del servidor (`server.cfg`):
   ```cfg
   ensure d87-pausemenu
   ```

---

## ⚙️ Configuración (Configuration)

El archivo `config.lua` permite personalizar los accesos directos y los textos de la interfaz sin tocar la lógica del script:

```lua
Config = {}
Config.Framework = "qbx" -- Tu framework seleccionado

Config.Locales = {
    map = "MAPA",
    settings = "AJUSTES",
    report = "REPORTAR",
    battlepass = "BATTLEPASS",
    skins = "SKINS"
}

Config.Links = {
    web = "https://tu-web.com",
    discord = "https://discord.gg",
    rules = "https://tu-web.com",
    store = "https://tu-servidor.com"
}
```

---

## 📸 Previsualización (Preview)

La interfaz se despliega sobre una cuadrícula limpia que incluye:
* Marcadores financieros superiores.
* Botones directos al mapa del juego y menú de ajustes nativo de GTA V.
* Redirecciones configurables para redes sociales del servidor (Discord, Web, Tienda).

---

## 📝 Licencia (License)

Este proyecto está bajo la licencia **MIT**. Puedes usarlo, modificarlo y distribuirlo libremente en tus servidores. Créditos a **Drako87/Dracatt**.
