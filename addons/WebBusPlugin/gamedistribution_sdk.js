var ad_start
var ad_stop
var ad_rewarded
var gd_id

(function setcallbacks(callbacks, game_dist_id) {
    ad_stop = callbacks["ad_stop"]
    ad_start = callbacks["ad_start"]
    ad_rewarded = callbacks["ad_rewarded"]
    gd_id = game_dist_id
}
)



window["GD_OPTIONS"] = {
    "gameId": gd_id,
    "onEvent": function(event) {
        switch (event.name) {
            case "SDK_GAME_START":
                // advertisement done, resume game logic and unmute audio
                ad_stop(null)
                break;
            case "SDK_GAME_PAUSE":
                // pause game logic / mute audio
                ad_start(null)
                break;
            case "SDK_GDPR_TRACKING":
                // this event is triggered when your user doesn't want to be tracked
                break;
            case "SDK_GDPR_TARGETING":
                // this event is triggered when your user doesn't want personalised targeting of ads and such
                break;
            case "SDK_REWARDED_WATCH_COMPLETE":
                // this event is triggered when your user completely watched rewarded ad
                ad_rewarded(null)
                break;
        }
    },
};
(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s);
    js.id = id;
    js.src = 'https://html5.api.gamedistribution.com/main.min.js';
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'gamedistribution-jssdk'));