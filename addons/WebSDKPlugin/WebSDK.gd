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

const LANGUAGE_CODES = {'AF': 'uz', 'AX': 'sv', 'AL': 'en', 'DZ': 'kab', 'AS': 'en', 'AD': 'en', 'AO': 'pt', 'AI': 'es', 'AG': 'es', 'AR': 'es', 'AM': 'hy', 'AW': 'es', 'AU': 'en', 'AT': 'de', 'AZ': 'az', 'BS': 'es', 'BH': 'ar', 'BD': 'en', 'BB': 'es', 'BY': 'ru', 'BE': 'wa', 'BZ': 'es', 'BJ': 'yo', 'BM': 'es', 'BT': 'dz', 'BO': 'es', 'BA': 'sr', 'BW': 'tn', 'BR': 'es', 'IO': 'en', 'VG': 'es', 'BN': 'ms', 'BG': 'en', 'BF': 'ff', 'BI': 'rn', 'KH': 'km', 'CM': 'yav', 'CA': 'es', 'IC': 'es', 'CV': 'pt', 'BQ': 'es', 'KY': 'es', 'CF': 'sg', 'EA': 'es', 'TD': 'fr', 'CL': 'es', 'CN': 'ug', 'CX': 'en', 'CC': 'en', 'CO': 'es', 'KM': 'fr', 'CG': 'ln', 'CD': 'sw', 'CK': 'en', 'CR': 'es', 'CI': 'fr', 'HR': 'en', 'CU': 'es', 'CW': 'es', 'CY': 'tr', 'CZ': 'en', 'DK': 'fo', 'DG': 'en', 'DJ': 'so', 'DM': 'es', 'DO': 'es', 'EC': 'es', 'EG': 'ar', 'SV': 'es', 'GQ': 'es', 'ER': 'ti', 'EE': 'et', 'SZ': 'ss', 'ET': 'wal', '150': 'en', 'FK': 'es', 'FO': 'fo', 'FJ': 'en', 'FI': 'sv', 'FR': 'gsw', 'GF': 'es', 'PF': 'fr', 'GA': 'fr', 'GM': 'ff', 'GE': 'os', 'DE': 'hsb', 'GH': 'ha', 'GI': 'en', 'GR': 'el', 'GL': 'es', 'GD': 'es', 'GP': 'es', 'GU': 'en', 'GT': 'es', 'GG': 'en', 'GW': 'pt', 'GN': 'nqo', 'GY': 'es', 'HT': 'es', 'HN': 'es', 'HK': 'en', 'HU': 'hu', 'IS': 'is', 'IN': 'ur', 'ID': 'jv', 'IR': 'fa', 'IQ': 'syr', 'IE': 'ga', 'IM': 'gv', 'IL': 'he', 'IT': 'scn', 'JM': 'en', 'JP': 'ja', 'JE': 'en', 'JO': 'ar', 'KZ': 'ru', 'KE': 'teo', 'KI': 'en', 'XK': 'sr', 'KW': 'ar', 'KG': 'ru', 'LA': 'lo', '419': 'es', 'LV': 'lv', 'LB': 'ar', 'LS': 'st', 'LR': 'vai', 'LY': 'ar', 'LI': 'gsw', 'LT': 'lt', 'LU': 'pt', 'MO': 'pt', 'MG': 'mg', 'MW': 'ny', 'MY': 'ta', 'MV': 'en', 'ML': 'ses', 'MT': 'mt', 'MH': 'en', 'MQ': 'es', 'MR': 'ff', 'MU': 'mfe', 'YT': 'fr', 'MX': 'es', 'FM': 'en', 'MD': 'ru', 'MC': 'fr', 'MN': 'mn', 'ME': 'sr', 'MS': 'es', 'MA': 'shi', 'MZ': 'seh', 'MM': 'en', 'NA': 'naq', 'NR': 'en', 'NP': 'ne', 'NL': 'fy', 'NC': 'fr', 'NZ': 'mi', 'NI': 'es', 'NE': 'dje', 'NG': 'yo', 'NU': 'en', 'NF': 'en', 'KP': 'ko', 'MK': 'mk', 'MP': 'en', 'NO': 'nn', 'OM': 'ar', 'PK': 'ur', 'PW': 'en', 'PS': 'ar', 'PA': 'es', 'PG': 'en', 'PY': 'es', 'PE': 'es', 'PH': 'es', 'PN': 'en', 'PL': 'pl', 'PT': 'pt', 'PR': 'es', 'QA': 'ar', 'RE': 'fr', 'RO': 'ro', 'RU': 'tt', 'RW': 'rw', 'WS': 'en', 'SM': 'it', 'ST': 'pt', 'SA': 'en', 'SN': 'wo', 'RS': 'sr', 'SC': 'fr', 'SL': 'ff', 'SG': 'ta', 'SX': 'es', 'SK': 'sk', 'SI': 'sl', 'SB': 'en', 'SO': 'so', 'ZA': 'zu', 'KR': 'ko', 'SS': 'nus', 'ES': 'es', 'LK': 'ta', 'BL': 'es', 'SH': 'en', 'KN': 'es', 'LC': 'es', 'MF': 'es', 'PM': 'es', 'VC': 'es', 'SD': 'en', 'SR': 'es', 'SJ': 'nb', 'SE': 'sv', 'CH': 'wae', 'SY': 'syr', 'TW': 'trv', 'TJ': 'tg', 'TZ': 'vun', 'TH': 'th', 'TL': 'pt', 'TG': 'fr', 'TK': 'en', 'TO': 'to', 'TT': 'es', 'TN': 'fr', 'TR': 'tr', 'TM': 'tk', 'TC': 'es', 'TV': 'en', 'UM': 'en', 'VI': 'es', 'UG': 'teo', 'UA': 'uk', 'AE': 'en', 'GB': 'cy', 'US': 'es', 'UY': 'es', 'UZ': 'uz', 'VU': 'fr', 'VA': 'it', 'VE': 'es', 'VN': 'vi', 'WF': 'fr', 'EH': 'ar', '001': 'yi', 'YE': 'ar', 'ZM': 'en', 'ZW': 'sn'}

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
				print("waiting sdk..")
				while not CrazySDK:
					CrazySDK = window.CrazyGames.SDK
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
		elif OS.has_feature("gamedistribution"):
			game_dist_show_rewarded_ad()
	
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

# Game Distribution
func game_dist_show_ad():
	while not GameDistSDK:
		await _SDK_inited
	GameDistSDK.show_ad()
	
func game_dist_show_rewarded_ad():
	while not GameDistSDK:
		await _SDK_inited
	GameDistSDK.show_ad('rewarded')

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
			var c_code = system_info.countryCode
			lang = LANGUAGE_CODES[c_code]
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
