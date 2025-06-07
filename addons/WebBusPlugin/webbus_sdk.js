let lb;
let ysdk;
let platform

let url = window.location.href

if (url.includes('yandex')) {
    window.platform = 'yandex'
}
if (url.includes('crazygames')) {
    window.platform = 'crazy'
}
if (url.includes('gamedistribution')) {
    window.platform = 'gamedistribution'
}
if (url.includes('poki')) {
    window.platform = 'poki'
}
if (url.includes('vk')) {
    window.platform = 'vk'
}
if (window.platform == null) {
    window.platform = 'unknown'
}
let url_src
switch (window.platform) {
    case "yandex":
        url_src="/sdk.js";
        var script = document.createElement('script');
        script.src = url_src;
        document.head.appendChild(script);
        console.log("Yandex JS init");
        break;
    case "crazy":
        url_src="https://sdk.crazygames.com/crazygames-sdk-v3.js";
        var script = document.createElement('script');
        script.src = url_src;
        document.head.appendChild(script);
        console.log("Crazy JS init");
        break;
    case "poki":
        url_src="https://game-cdn.poki.com/scripts/v2/poki-sdk.js";
        var script = document.createElement('script');
        script.src = url_src;
        document.head.appendChild(script);
        console.log("Poki JS init");
        break;
    case "vk":
        url_src="https://unpkg.com/@vkontakte/vk-bridge@2.15.6/dist/browser.min.js";
        var script = document.createElement('script');
        script.src = url_src;
        document.head.appendChild(script);
        console.log("VK JS init");
        break;
    case "gamedistribution":
        url_src="https://html5.api.gamedistribution.com/main.bundle.js";
        var script = document.createElement('script');
        script.src
        document.head.appendChild(script);
        console.log("GameDistribution JS init");
        break;
    default:
        console.log("Platform not found");
}