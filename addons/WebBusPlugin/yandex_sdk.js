let lb;
let ysdk;
let yandex_init = false;
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

function GetLeaderboardInfo(leaderboardName, callback){
    console.log('Getting leaderboard', leaderboardName, "description");
    lb.getLeaderboardDescription(leaderboardName).then((_info) => {
        callback(_info);
        console.log(_info)
    }).catch(err => {
        console.log('Leaderboard description load error');
    });
}