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

	
func show_ad():
	if OS.get_name() == "Web":
		if OS.has_feature("crazygames"):
			crazy_show_ad()
		elif OS.has_feature("yandexgames"):
			yandex_show_ad()

func show_rewarded_ad():
	if OS.get_name() == "Web":
		if OS.has_feature("crazygames"):
			crazy_show_rewarded_ad()
		elif OS.has_feature("yandexgames"):
			yandex_show_rewarded_ad()
	
	
# Yandex Games Block

func yandex_show_ad():
	YandexSDK.adv.showFullscreenAdv(adCallbacks)

func yandex_show_rewarded_ad():
	YandexSDK.adv.showRewardedVideo(adRewardCallbacks)

# Crazy Games

func crazy_show_ad():
	CrazySDK.ad.requestAd("midgame", adCallbacks)
	
func crazy_show_rewarded_ad():
	CrazySDK.ad.requestAd("rewarded", adRewardCallbacks)


#Callbacks
func _rewarded_ad(args):
	reward_added.emit()
	
func _ad(args):
	ad_closed.emit()
	
func _adError(args):
	ad_error.emit()
	
func _adStarted(args):
	ad_started.emit()

func set_yandex_leaderboard(leaderboard:String, score: int, extra_data:String = ""):
	if OS.has_feature("yandexgames"):
		window.SaveLeaderboardScore(leaderboard, score, extra_data)

signal language_recieved

func get_language():
	var lang:String
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


