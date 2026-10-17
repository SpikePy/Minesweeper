// Service Worker: macht das Spiel installierbar und offline spielbar.
// Netzwerk zuerst (damit Updates sofort ankommen), bei fehlender Verbindung aus dem Cache.
// Anfragen an andere Server (Supabase) laufen unverändert durch.
const CACHE = 'minesweeper-v18';
const SHELL = ['./', 'index.html', 'manifest.webmanifest', 'favicon.svg',
  'icons/icon-192.png', 'icons/icon-512.png', 'icons/icon-maskable-512.png', 'icons/apple-touch-icon.png',
  'faces/ok.png', 'faces/ouch.png', 'faces/dead.png', 'faces/win.png',
  'doom/wall.png', 'doom/mine.png', 'doom/boom.png', 'doom/flag.png', 'doom/gear.png',
  ...['P01', 'P02', 'P03', 'P04', 'P05', 'P06', 'P07', 'P10', 'P12'].map(p => `doom/plates/${p}.png`),
  'doom/open.wav', 'doom/area.wav', 'doom/flag.wav', 'doom/unflag.wav', 'doom/win.wav', 'doom/boom.wav',
  'doom/die.wav', 'doom/start.wav', 'doom/menu.wav', 'doom/setting.wav', 'doom/close.wav'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(SHELL)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(caches.keys()
    .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
    .then(() => self.clients.claim()));
});

self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET' || new URL(req.url).origin !== location.origin) return;
  e.respondWith(fetch(req).then(res => {
    if (res.ok) { const copy = res.clone(); caches.open(CACHE).then(c => c.put(req, copy)); }
    return res;
  }).catch(() => caches.match(req, { ignoreSearch: true })
    .then(hit => hit || (req.mode === 'navigate' ? caches.match('./') : Response.error()))));
});
