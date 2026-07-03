window.addEventListener('message', function(event) {
    let item = event.data;

    if (item.action === "open") {
        document.getElementById('app').style.display = 'flex';
        
        // Inyección del Nombre Completo del Personaje Rolero
        document.getElementById('player-charname').innerText = item.data.charName.toUpperCase();
        
        document.getElementById('player-id').innerText = item.data.id;
        document.getElementById('player-cash').innerText = item.data.cash.toLocaleString();
        document.getElementById('player-bank').innerText = item.data.bank.toLocaleString();
        document.getElementById('player-job').innerText = item.data.job.toUpperCase();
        
        document.getElementById('count-police').innerText = item.data.police;
        document.getElementById('count-ems').innerText = item.data.ems;
        document.getElementById('count-mechanic').innerText = item.data.mechanic;
        document.getElementById('count-staff').innerText = item.data.staff;
        document.getElementById('count-online').innerText = item.data.online;
        
        document.getElementById('player-hours').innerText = item.data.hours;
        
        document.getElementById('news-title').innerText = item.data.announcementTitle;
        document.getElementById('news-desc').innerText = item.data.announcementDesc;
        document.getElementById('news01-title').innerText = item.data.announcement01Title;
        document.getElementById('news01-desc').innerText = item.data.announcement01Desc;
        document.getElementById('news02-title').innerText = item.data.announcement02Title;
        document.getElementById('news02-desc').innerText = item.data.announcement02Desc;

        // INYECCIÓN DINÁMICA DE FONDOS DESDE EL CONFIG
        document.getElementById('card-map').style.backgroundImage = `linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.7)), url('${item.data.backgrounds.map}')`;
        document.getElementById('card-settings').style.backgroundImage = `linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.7)), url('${item.data.backgrounds.settings}')`;
        document.getElementById('card-rules').style.backgroundImage = `linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.7)), url('${item.data.backgrounds.rules}')`;
        document.getElementById('card-report').style.backgroundImage = `linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.7)), url('${item.data.backgrounds.report}')`;
        document.getElementById('card-battlepass').style.backgroundImage = `linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.7)), url('${item.data.backgrounds.battlepass}')`;

        // Textos Traducibles
        document.getElementById('lbl-map').innerText = item.data.locales.map;
        document.getElementById('lbl-settings').innerText = item.data.locales.settings;
        document.getElementById('lbl-rules').innerText = item.data.locales.rules;
        document.getElementById('lbl-report').innerText = item.data.locales.report;
        document.getElementById('lbl-disconnect').innerText = item.data.locales.disconnect;
        document.getElementById('lbl-battlepass').innerText = item.data.locales.battlepass;
        document.getElementById('lbl-news').innerText = item.data.locales.news;
        document.getElementById('lbl-unstick').innerText = item.data.locales.unstick;
        document.getElementById('lbl-fps').innerText = item.data.locales.fps;
        document.getElementById('lbl-streamer').innerText = item.data.locales.streamer;
    }

    if (item.action === "close") {
        document.getElementById('app').style.display = 'none';
    }
});

window.addEventListener('keydown', function(event) {
    if (event.key === "Escape") {
        fetch(`https://${GetParentResourceName()}/close`, { method: 'POST' });
    }
});

function triggerAction(type) {
    fetch(`https://${GetParentResourceName()}/action`, {
        method: 'POST',
        body: JSON.stringify({ type: type })
    });
}

function openLink(name) {
    fetch(`https://${GetParentResourceName()}/action`, {
        method: 'POST',
        body: JSON.stringify({ type: 'link', name: name })
    });
}

function toggleOption(name) {
    fetch(`https://${GetParentResourceName()}/action`, {
        method: 'POST',
        body: JSON.stringify({ type: 'toggle', name: name })
    })
    .then(res => res.json())
    .then(data => {
        let cardElement = event.currentTarget;
        let iconElement = document.getElementById(`icon-${name}`);
        
        if (data.status) {
            cardElement.classList.add('active');
            if(name === 'streamer') {
                iconElement.className = "fa-solid fa-eye-slash";
                document.getElementById('streamer-hide-header').style.opacity = "0.0";
            }
        } else {
            cardElement.classList.remove('active');
            if(name === 'streamer') {
                iconElement.className = "fa-solid fa-eye";
                document.getElementById('streamer-hide-header').style.opacity = "1.0";
            }
        }
    });
}
