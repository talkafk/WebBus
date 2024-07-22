let lb;
let ysdk;
YaGames.init().then(_ysdk => {
    ysdk = _ysdk; 
    _ysdk.getLeaderboards() .then(_lb => lb = _lb);
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