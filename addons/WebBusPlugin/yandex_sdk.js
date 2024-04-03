var lb;
var ysdk;
var yandex_init = false;
YaGames.init().then(_ysdk => { window.ysdk = _ysdk;
ysdk = _ysdk; 
_ysdk.getLeaderboards() .then(_lb => lb = _lb);
yandex_init = true;
console.log("Yandex init");
});


function SaveLeaderboardScore(leaderboardName, score, extraData) {
    console.log('Save leaderboard score', score, "on", leaderboardName, "with", extraData);
    lb.setLeaderboardScore(leaderboardName, score, extraData).then(() => {
        console.log('Leaderboard score saved');
    });
}

async function GetLeaderboardInfo(leaderboardName){
    console.log('Getting leaderboard', leaderboardName, "info")
    var info = await lb.getLeaderboardDescription(leaderboardName)
    return info
}

function GetLang(callback) {
 	console.log('Get language');
	callback(ysdk.environment.i18n.lang);
}

