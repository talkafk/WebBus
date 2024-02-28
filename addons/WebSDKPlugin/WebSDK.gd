extends Node

signal _SDK_inited
signal reward_added
signal ad_closed
signal ad_error
signal ad_started 

var adCallbacks = null
var adRewardCallbacks = null
var adStartedCallback = null
var adErrorCallback = null
var adFinishedCallback = null
var adFinishedRewardCallback = null
var window = null

var YandexSDK = null
var CrazySDK = null
var GameDistSDK = null

#region _ready
func _ready():
	match OS.get_name():
		"Web":
			window = JavaScriptBridge.get_interface("window")
			adCallbacks = JavaScriptBridge.create_object("Object")
			adRewardCallbacks = JavaScriptBridge.create_object("Object")
			adStartedCallback = JavaScriptBridge.create_callback(_adStarted)
			adErrorCallback = JavaScriptBridge.create_callback(_adError)
			adFinishedCallback = JavaScriptBridge.create_callback(_ad)
			adFinishedRewardCallback = JavaScriptBridge.create_callback(_rewarded_ad)
			if OS.has_feature("yandexgames"):
				var callbacks = JavaScriptBridge.create_object("Object")
				var rewardcallbacks = JavaScriptBridge.create_object("Object")
				callbacks["onClose"] = adFinishedCallback
				callbacks["onError"] = adErrorCallback
				callbacks["onOffline"] = adErrorCallback
				callbacks["onOpen"] = adStartedCallback
				adCallbacks["callbacks"] = callbacks
				rewardcallbacks["onRewarded"] = adFinishedRewardCallback
				rewardcallbacks["onError"] = adErrorCallback
				rewardcallbacks["onClose"] = adFinishedCallback
				rewardcallbacks["onOpen"] = adStartedCallback
				adRewardCallbacks["callbacks"] = rewardcallbacks
				while not YandexSDK:
					YandexSDK = JavaScriptBridge.get_interface("Window").ysdk
					await get_tree().create_timer(0.1).timeout # ждём яндекс sdk
				emit_signal("_SDK_inited")
				print('gd init yandex')
			elif OS.has_feature("crazygames"):
				adCallbacks["adFinished"] = adFinishedCallback
				adCallbacks["adError"] = adErrorCallback
				adCallbacks["adStarted"] = adStartedCallback
				adRewardCallbacks["adFinished"] = adFinishedRewardCallback
				adRewardCallbacks["adError"] = adErrorCallback
				adRewardCallbacks["adStarted"] = adStartedCallback
				while not CrazySDK:
					CrazySDK = JavaScriptBridge.get_interface("Window").CrazyGames.SDK
					await get_tree().create_timer(0.1).timeout
					
				var callback = JavaScriptBridge.create_callback(_callback_crazy_system_info)
				CrazySDK.user.getSystemInfo(callback)
				await _system_info_recieved
				
				emit_signal("_SDK_inited")
				print('gd init crazy')
			elif OS.has_feature("gamedistribution"):
				adCallbacks["ad_stop"] = adFinishedCallback
				adCallbacks["ad_start"] = adStartedCallback
				adCallbacks["ad_rewarded"] = adFinishedRewardCallback
				window.setcallbacks(adCallbacks)
				GameDistSDK = window.gdsdk
				emit_signal("_SDK_inited")
				print('gd init gamedistribution')
#endregion
#region Ads
func show_ad():
	if OS.get_name() == "Web":
		if OS.has_feature("crazygames"):
			crazy_show_ad()
		elif OS.has_feature("yandexgames"):
			yandex_show_ad()
		elif OS.has_feature("gamedistribution"):
			game_dist_show_ad()

func show_rewarded_ad():
	if OS.get_name() == "Web":
		if OS.has_feature("crazygames"):
			crazy_show_rewarded_ad()
		elif OS.has_feature("yandexgames"):
			yandex_show_rewarded_ad()
	
	
# Yandex Games Block

func yandex_show_ad():
	while not YandexSDK:
		await _SDK_inited
	YandexSDK.adv.showFullscreenAdv(adCallbacks)

func yandex_show_rewarded_ad():
	while not YandexSDK:
		await _SDK_inited
	YandexSDK.adv.showRewardedVideo(adRewardCallbacks)

# Crazy Games

func crazy_show_ad():
	while not CrazySDK:
		await _SDK_inited
	CrazySDK.ad.requestAd("midgame", adCallbacks)
	
func crazy_show_rewarded_ad():
	while not CrazySDK:
		await _SDK_inited
	CrazySDK.ad.requestAd("rewarded", adRewardCallbacks)

func game_dist_show_ad():
	while not GameDistSDK:
		await _SDK_inited
	GameDistSDK.show_ad()

#Callbacks
func _rewarded_ad(args):
	reward_added.emit()
	
func _ad(args):
	ad_closed.emit()
	
func _adError(args):
	ad_error.emit()
	
func _adStarted(args):
	ad_started.emit()

#TODO need test banner
func show_banner():
	if OS.has_feature("yandexgames"):
		while not YandexSDK:
			await _SDK_inited
		YandexSDK.adv.showBannerAdv()
	elif OS.has_feature("crazygames"):
		while not CrazySDK:
			await _SDK_inited
		JavaScriptBridge.eval('document.getElementById("responsive-banner-container").style.display = "block"')
		CrazySDK.banner.requestResponsiveBanner("responsive-banner-container")
		
func hide_banner():
	if OS.has_feature("yandexgames"):
		YandexSDK.adv.hideBannerAdv()
	elif OS.has_feature("crazygames"):
		JavaScriptBridge.eval('document.getElementById("responsive-banner-container").style.display = "none"')
		CrazySDK.banner.clearBanner("responsive-banner-container")
#endregion
#region Yandex

func yandex_ready():
	if OS.has_feature("yandexgames"):
		JavaScriptBridge.eval("ysdk.features.LoadingAPI?.ready()")

signal leaderboard_info_recieved

#TODO need test
func get_leaderboard_info(leaderboard:String):
	if OS.has_feature("yandexgames"):
		while not YandexSDK:
			await _SDK_inited
		var info:JavaScriptObject = await window.GetLeaderboardInfo(leaderboard)
		leaderboard_info_recieved.emit(info)


func set_yandex_leaderboard(leaderboard:String, score: int, extra_data:String = ""):
	if OS.has_feature("yandexgames"):
		window.SaveLeaderboardScore(leaderboard, score, extra_data)
#endregion

#region Crazy Games
func crazy_happytime():
	if CrazySDK:
		CrazySDK.game.happytime()
	else:
		push_warning("SDK not initialized")
	
func crazy_start_gameplay():
	if CrazySDK:
		CrazySDK.game.gameplayStart()
	else:
		push_warning("SDK not initialized")
	
func crazy_stop_gameplay():
	if CrazySDK:
		CrazySDK.game.gameplayStop()
	else:
		push_warning("SDK not initialized")
	
func crazy_start_loading():
	if CrazySDK:
		CrazySDK.game.sdkGameLoadingStart()
	else:
		push_warning("SDK not initialized")
	
func crazy_stop_loading():
	if CrazySDK:
		CrazySDK.game.sdkGameLoadingStop()
	else:
		push_warning("SDK not initialized")
	
#endregion

#region getting data
signal language_recieved

func get_language():
	var lang:String
	if OS.get_name() == "Web":
		if OS.has_feature("yandexgames"):
			while not YandexSDK:
				await _SDK_inited
			lang = YandexSDK.environment.i18n.lang
		elif OS.has_feature("crazygames"):
			while not system_info:
				await _SDK_inited
			lang = system_info.countryCode
		lang = lang.to_lower()
		if lang == 'us':
			lang = 'en'
		print("language from sdk: ", lang)
		language_recieved.emit(lang)


signal type_device_recieved

func get_type_device():
	var type:String
	if OS.get_name() == "Web":
		if OS.has_feature("crazygames"):
			while not system_info:
				await _SDK_inited 
			type = system_info.device.type
		elif OS.has_feature("yandexgames"):
			while not YandexSDK:
				await _SDK_inited
			type = YandexSDK.deviceInfo.type
		print("type device is ", type)
		emit_signal("type_device_recieved", type)


signal _system_info_recieved
var system_info:JavaScriptObject

func _callback_crazy_system_info(args:Array):
	system_info = args[1]
	emit_signal("_system_info_recieved", system_info)
#endregion
