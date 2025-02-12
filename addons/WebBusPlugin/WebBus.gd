extends Node

signal _SDK_inited
signal reward_added
signal ad_closed
signal ad_error
signal ad_started 

var _adCallbacks:JavaScriptObject
var _adRewardCallbacks:JavaScriptObject
var _adStartedCallback:JavaScriptObject
var _adErrorCallback:JavaScriptObject
var _adFinishedCallback:JavaScriptObject
var _adFinishedRewardCallback:JavaScriptObject
var window:JavaScriptObject

var YandexSDK:JavaScriptObject
var leaderboards:JavaScriptObject
var CrazySDK:JavaScriptObject
var GameDistSDK:JavaScriptObject

var info := {}

const LANGUAGE_CODES = {'AF': 'uz', 'AX': 'sv', 'AL': 'en', 'DZ': 'kab',
 'AS': 'en', 'AD': 'en', 'AO': 'pt', 'AI': 'es', 'AG': 'es', 'AR': 'es',
 'AM': 'hy', 'AW': 'es', 'AU': 'en', 'AT': 'de', 'AZ': 'az', 'BS': 'es',
 'BH': 'ar', 'BD': 'en', 'BB': 'es', 'BY': 'ru', 'BE': 'wa', 'BZ': 'es',
 'BJ': 'yo', 'BM': 'es', 'BT': 'dz', 'BO': 'es', 'BA': 'sr', 'BW': 'tn',
 'BR': 'es', 'IO': 'en', 'VG': 'es', 'BN': 'ms', 'BG': 'en', 'BF': 'ff',
 'BI': 'rn', 'KH': 'km', 'CM': 'yav', 'CA': 'es', 'IC': 'es', 'CV': 'pt',
 'BQ': 'es', 'KY': 'es', 'CF': 'sg', 'EA': 'es', 'TD': 'fr', 'CL': 'es',
 'CN': 'ug', 'CX': 'en', 'CC': 'en', 'CO': 'es', 'KM': 'fr', 'CG': 'ln',
 'CD': 'sw', 'CK': 'en', 'CR': 'es', 'CI': 'fr', 'HR': 'en', 'CU': 'es',
 'CW': 'es', 'CY': 'tr', 'CZ': 'en', 'DK': 'fo', 'DG': 'en', 'DJ': 'so',
 'DM': 'es', 'DO': 'es', 'EC': 'es', 'EG': 'ar', 'SV': 'es', 'GQ': 'es',
 'ER': 'ti', 'EE': 'et', 'SZ': 'ss', 'ET': 'wal', '150': 'en', 'FK': 'es',
 'FO': 'fo', 'FJ': 'en', 'FI': 'sv', 'FR': 'gsw', 'GF': 'es', 'PF': 'fr',
 'GA': 'fr', 'GM': 'ff', 'GE': 'os', 'DE': 'hsb', 'GH': 'ha', 'GI': 'en',
 'GR': 'el', 'GL': 'es', 'GD': 'es', 'GP': 'es', 'GU': 'en', 'GT': 'es',
 'GG': 'en', 'GW': 'pt', 'GN': 'nqo', 'GY': 'es', 'HT': 'es', 'HN': 'es',
 'HK': 'en', 'HU': 'hu', 'IS': 'is', 'IN': 'ur', 'ID': 'jv', 'IR': 'fa',
 'IQ': 'syr', 'IE': 'ga', 'IM': 'gv', 'IL': 'he', 'IT': 'scn', 'JM': 'en',
 'JP': 'ja', 'JE': 'en', 'JO': 'ar', 'KZ': 'ru', 'KE': 'teo', 'KI': 'en',
 'XK': 'sr', 'KW': 'ar', 'KG': 'ru', 'LA': 'lo', '419': 'es', 'LV': 'lv',
 'LB': 'ar', 'LS': 'st', 'LR': 'vai', 'LY': 'ar', 'LI': 'gsw', 'LT': 'lt',
 'LU': 'pt', 'MO': 'pt', 'MG': 'mg', 'MW': 'ny', 'MY': 'ta', 'MV': 'en',
 'ML': 'ses', 'MT': 'mt', 'MH': 'en', 'MQ': 'es', 'MR': 'ff', 'MU': 'mfe',
 'YT': 'fr', 'MX': 'es', 'FM': 'en', 'MD': 'ru', 'MC': 'fr', 'MN': 'mn',
 'ME': 'sr', 'MS': 'es', 'MA': 'shi', 'MZ': 'seh', 'MM': 'en', 'NA': 'naq',
 'NR': 'en', 'NP': 'ne', 'NL': 'fy', 'NC': 'fr', 'NZ': 'mi', 'NI': 'es',
 'NE': 'dje', 'NG': 'yo', 'NU': 'en', 'NF': 'en', 'KP': 'ko', 'MK': 'mk',
 'MP': 'en', 'NO': 'nn', 'OM': 'ar', 'PK': 'ur', 'PW': 'en', 'PS': 'ar',
 'PA': 'es', 'PG': 'en', 'PY': 'es', 'PE': 'es', 'PH': 'es', 'PN': 'en',
 'PL': 'pl', 'PT': 'pt', 'PR': 'es', 'QA': 'ar', 'RE': 'fr', 'RO': 'ro',
 'RU': 'ru', 'RW': 'rw', 'WS': 'en', 'SM': 'it', 'ST': 'pt', 'SA': 'en',
 'SN': 'wo', 'RS': 'sr', 'SC': 'fr', 'SL': 'ff', 'SG': 'ta', 'SX': 'es',
 'SK': 'sk', 'SI': 'sl', 'SB': 'en', 'SO': 'so', 'ZA': 'zu', 'KR': 'ko',
 'SS': 'nus', 'ES': 'es', 'LK': 'ta', 'BL': 'es', 'SH': 'en', 'KN': 'es',
 'LC': 'es', 'MF': 'es', 'PM': 'es', 'VC': 'es', 'SD': 'en', 'SR': 'es',
 'SJ': 'nb', 'SE': 'sv', 'CH': 'wae', 'SY': 'syr', 'TW': 'trv', 'TJ': 'tg',
 'TZ': 'vun', 'TH': 'th', 'TL': 'pt', 'TG': 'fr', 'TK': 'en', 'TO': 'to',
 'TT': 'es', 'TN': 'fr', 'TR': 'tr', 'TM': 'tk', 'TC': 'es', 'TV': 'en',
 'UM': 'en', 'VI': 'es', 'UG': 'teo', 'UA': 'uk', 'AE': 'en', 'GB': 'cy',
 'US': 'en', 'UY': 'es', 'UZ': 'uz', 'VU': 'fr', 'VA': 'it', 'VE': 'es',
 'VN': 'vi', 'WF': 'fr', 'EH': 'ar', '001': 'yi', 'YE': 'ar', 'ZM': 'en',
 'ZW': 'sn'}

enum Platform {YANDEX, CRAZY, GAMEDISTRIBUTION}

var platform : int

signal _inited
signal _system_info_recieved
var system_info


#region _ready
func _ready():
	match OS.get_name():
		"Web":
			window = JavaScriptBridge.get_interface("window")
			_adCallbacks = JavaScriptBridge.create_object("Object")
			_adRewardCallbacks = JavaScriptBridge.create_object("Object")
			_adStartedCallback = JavaScriptBridge.create_callback(_adStarted)
			_adErrorCallback = JavaScriptBridge.create_callback(_adError)
			_adFinishedCallback = JavaScriptBridge.create_callback(_ad)
			_adFinishedRewardCallback = JavaScriptBridge.create_callback(_rewarded_ad)
			var str_palform = window.platform
			match window.platform:
				"yandex":
					platform = Platform.YANDEX
				"crazy":
					platform = Platform.CRAZY
				"gamedistribution":
					platform = Platform.GAMEDISTRIBUTION
			match platform:
				Platform.YANDEX:
					var callbacks = JavaScriptBridge.create_object("Object")
					var rewardcallbacks = JavaScriptBridge.create_object("Object")
					callbacks["onClose"] = _adFinishedCallback
					callbacks["onError"] = _adErrorCallback
					callbacks["onOffline"] = _adErrorCallback
					callbacks["onOpen"] = _adStartedCallback
					_adCallbacks["callbacks"] = callbacks
					rewardcallbacks["onRewarded"] = _adFinishedRewardCallback
					rewardcallbacks["onError"] = _adErrorCallback
					rewardcallbacks["onClose"] = _adFinishedCallback
					rewardcallbacks["onOpen"] = _adStartedCallback
					_adRewardCallbacks["callbacks"] = rewardcallbacks
					print('waiting sdk..')
					while not window.YaGames:
						await get_tree().create_timer(0.1).timeout
					var _lb_callback := JavaScriptBridge.create_callback(func(args):
							leaderboards = args[0]
							_inited.emit())
					var _init_callback := JavaScriptBridge.create_callback(func(args):
						YandexSDK = args[0]
						YandexSDK.getLeaderboards().then(_lb_callback)
						)
					window.YaGames.init().then(_init_callback)
					await _inited
					emit_signal("_SDK_inited")
					print('gd init yandex')
				Platform.CRAZY:
					_adCallbacks["adFinished"] = _adFinishedCallback
					_adCallbacks["adError"] = _adErrorCallback
					_adCallbacks["adStarted"] = _adStartedCallback
					_adRewardCallbacks["adFinished"] = _adFinishedRewardCallback
					_adRewardCallbacks["adError"] = _adErrorCallback
					_adRewardCallbacks["adStarted"] = _adStartedCallback
					print("waiting sdk..")
					CrazySDK = window.CrazyGames.SDK
					while not CrazySDK:
						CrazySDK = window.CrazyGames.SDK
						await get_tree().create_timer(0.1).timeout
					var callback = JavaScriptBridge.create_callback(func(args:Array):
						system_info = args[1]
						emit_signal("_system_info_recieved", system_info))
					CrazySDK.user.getSystemInfo(callback)
					await _system_info_recieved
					
					emit_signal("_SDK_inited")
					print('gd init crazy')
				Platform.GAMEDISTRIBUTION:
					_adCallbacks["ad_stop"] = _adFinishedCallback
					_adCallbacks["ad_start"] = _adStartedCallback
					_adCallbacks["ad_rewarded"] = _adFinishedRewardCallback
					window.setcallbacks(_adCallbacks)
					GameDistSDK = window.gdsdk
					emit_signal("_SDK_inited")
					print('gd init gamedistribution')
			_get_info()
				
				
func _get_info():
	var lang:String
	var type:String
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			lang = YandexSDK.environment.i18n.lang
			type = YandexSDK.deviceInfo.type
		Platform.CRAZY: 
			while not system_info:
				await _SDK_inited
			var c_code = system_info.countryCode
			lang = LANGUAGE_CODES[c_code]
			type = system_info.device.type
	info["language"] = lang
	info["device_type"] = type
	
	
#endregion
#region Ads
func show_ad():
	if OS.get_name() == "Web":
		match platform:
			Platform.CRAZY:
				crazy_show_ad()
			Platform.YANDEX:
				yandex_show_ad()
			Platform.GAMEDISTRIBUTION:
				game_dist_show_ad()

func show_rewarded_ad():
	if OS.get_name() == "Web":
		match platform:
			Platform.CRAZY:
				crazy_show_rewarded_ad()
			Platform.YANDEX:
				yandex_show_rewarded_ad()
			Platform.GAMEDISTRIBUTION:
				game_dist_show_rewarded_ad()
	
# Yandex Games Block

func yandex_show_ad():
	while not YandexSDK:
		await _SDK_inited
	YandexSDK.adv.showFullscreenAdv(_adCallbacks)

func yandex_show_rewarded_ad():
	while not YandexSDK:
		await _SDK_inited
	YandexSDK.adv.showRewardedVideo(_adRewardCallbacks)

# Crazy Games

func crazy_show_ad():
	while not CrazySDK:
		await _SDK_inited
	CrazySDK.ad.requestAd("midgame", _adCallbacks)
	
func crazy_show_rewarded_ad():
	while not CrazySDK:
		await _SDK_inited
	CrazySDK.ad.requestAd("rewarded", _adRewardCallbacks)

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


func show_banner():
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.adv.showBannerAdv()
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			JavaScriptBridge.eval('document.getElementById("responsive-banner-container").style.display = "block"')
			CrazySDK.banner.requestResponsiveBanner("responsive-banner-container")
		
func hide_banner():	
	match platform:
		Platform.YANDEX:
			YandexSDK.adv.hideBannerAdv()
		Platform.CRAZY:
			JavaScriptBridge.eval('document.getElementById("responsive-banner-container").style.display = "none"')
			CrazySDK.banner.clearBanner("responsive-banner-container")
#endregion
#region game
	
func start_gameplay():
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.features.GameplayAPI.start()
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			CrazySDK.game.gameplayStart()
	
func stop_gameplay():
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.features.GameplayAPI.stop()
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			CrazySDK.game.gameplayStop()
	


func ready():
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.features.LoadingAPI.ready()
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			CrazySDK.game.sdkGameLoadingStop()

			
#endregion
#region Yandex

signal leaderboard_info_recieved
var callback_info_recieved = JavaScriptBridge.create_callback(_leaderboard_info_recieved)


func get_leaderboard_info(leaderboard:String):
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			leaderboards.getLeaderboardDescription(leaderboard).then(callback_info_recieved)
			return
			push_warning("Bad requst getting leaderboard")

func _leaderboard_info_recieved(info):
	leaderboard_info_recieved.emit(info[0])

signal leaderboard_score_setted

func set_leaderboard_score(leaderboard:String, score: int, extra_data:String = ""):
	match platform:
		Platform.YANDEX:
			while not leaderboards:
				await _SDK_inited
			leaderboards.setLeaderboardScore(leaderboard, score, extra_data).then(
				JavaScriptBridge.create_callback(func(args):
					leaderboard_score_setted.emit()
					)
			)
			return
	push_warning("Bad request setting leaderboard score")

signal leaderboard_player_entry_recieved
var callback_player_entry_recieved = JavaScriptBridge.create_callback(_leaderboard_player_entry_recieved)

func get_leaderboard_player_entry(leaderboard:String):
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			leaderboards.getLeaderboardPlayerEntry(leaderboard).then(callback_player_entry_recieved)
		
func _leaderboard_player_entry_recieved(info):
	leaderboard_player_entry_recieved.emit(info[0])
	
signal leaderboard_entries_recieved
var callback_entries_recieved = JavaScriptBridge.create_callback(_leaderboard_entries_recieved)

#TODO need test
func get_leaderboard_entries(leaderboard:String, include_user:bool = true, quantity_around:int = 5, quantity_top:int = 5):
	if OS.has_feature("yandexgames"):
		while not YandexSDK:
			await _SDK_inited
		var config := JavaScriptBridge.create_object("Object")
		config["includeUser"] = include_user
		config["quantityAround"] = quantity_around
		config["quantityTop"] = quantity_top
		leaderboards.getLeaderboardEntries(leaderboard, config).then(callback_entries_recieved)
		
func _leaderboard_entries_recieved(info):
	leaderboard_entries_recieved.emit(info[0])


#endregion

#region Crazy Games
func happytime():
	match platform:
		Platform.CRAZY:
			if CrazySDK:
				CrazySDK.game.happytime()
			else:
				push_warning("SDK not initialized")
	
func start_loading():
	match platform:
		Platform.CRAZY:
			if CrazySDK:
				CrazySDK.game.sdkGameLoadingStart()
			else:
				push_warning("SDK not initialized")
				
#endregion
#region getting data


func get_platform():
	if OS.get_name() == "Web":
		match platform:
			Platform.YANDEX:
				return "yandex"
			Platform.CRAZY:
				return "crazy_games"
			Platform.GAMEDISTRIBUTION:
				return "game_distribution"


func get_language():
	if OS.get_name() == "Web":
		if info:
			print("language from sdk:", info["language"])
			return info["language"]


func get_type_device():
	if OS.get_name() == "Web":
		if info:
			print("language from sdk:", info["device_type"])
			return info["device_type"]

#endregion

#region purchases
var payments:JavaScriptObject

var _init_payments_callback := JavaScriptBridge.create_callback(func(args):
	print('init_payments')
	payments = args[0])


func init_payments(signed:bool = false):
	var conf := JavaScriptBridge.create_object("Object")
	if signed:
		conf["signed"] = signed
	YandexSDK.getPayments(conf).then(_init_payments_callback)


signal _purchase(success:bool)

var _purchase_callback := JavaScriptBridge.create_callback(func(args):
	_purchase.emit(true))
var _purchase_error_callback := JavaScriptBridge.create_callback(func(args):
	print("Error purchase", _js_to_dict(args[0]))
	_purchase.emit(false))

func purchase(id:String, developer_payload:String = ""):
	var settings := JavaScriptBridge.create_object("Object")
	settings["id"] = id
	if developer_payload:
		settings["developerPayload"] = developer_payload
	if payments:
		payments.purchase(settings).then(_purchase_callback).catch(_purchase_error_callback)
	var result = await _purchase
	return result


signal _get_purchases(success:bool)

var _get_purchases_callback := JavaScriptBridge.create_callback(func(args):
	_get_purchases.emit(args[0]))

var _get_purchases_error_callback := JavaScriptBridge.create_callback(func(args):
	print("Error", _js_to_dict(args[0]))
	_get_purchases.emit(false))

func get_purchases() -> Array:
	if payments:
		payments.getPurchases().then(_get_purchases_callback).catch(_get_purchases_error_callback)
	var result = await _get_purchases
	if result:
		return _js_to_dict(result)
	else:
		return []


func get_catalog() -> Array:
	if payments:
		payments.getCatalog().then(_get_purchases_callback).catch(_get_purchases_error_callback)
	var result = await _get_purchases
	if result:
		return _js_to_dict(result)
	else:
		return []



#endregion
#region tool

func _js_to_dict(js_object:JavaScriptObject) -> Variant:
	var window := JavaScriptBridge.get_interface("window")
	var strn = window.JSON.stringify(js_object).to_snake_case()
	return JSON.parse_string(strn)
	
#endregion
