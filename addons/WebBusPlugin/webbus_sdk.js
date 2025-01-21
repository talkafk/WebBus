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
        url_src="https://sdk.crazygames.com/crazygames-sdk-v2.js";
        var script = document.createElement('script');
        script.src = url_src;
        document.head.appendChild(script);
        console.log("Crazy JS init");
        break;
}




function SaveLeaderboardScore(leaderboardName, score, extraData) {
    console.log('Save leaderboard score', score, "on", leaderboardName, "with", extraData);
    lb.setLeaderboardScore(leaderboardName, score, extraData).then(() => {
        console.log('Leaderboard score saved');
    });
}

function GetLeaderboardInfo(leaderboardName, callback){
    console.log('Getting leaderboard', leaderboardName, "description");
    lb.getLeaderboardDescription(leaderboardName).then((_info) => {
        callback(_info);
    });
}

function GetLeaderboardPlayerEntry(leaderboardName, callback){
    console.log('Getting leaderboard', leaderboardName, "player entry");
    lb.getLeaderboardPlayerEntry(leaderboardName).then((_res) => {
        callback(_res);
    });
}

function GetLeaderboardEntries(leaderboardName, config, callback) {
    console.log('Getting leaderboard', leaderboardName, "entries");
    lb.getLeaderboardEntries(leaderboardName, config).then((_res) => {
        callback(_res);
    });
}
