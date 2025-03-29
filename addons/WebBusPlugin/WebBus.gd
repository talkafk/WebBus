extends Node

signal _SDK_inited
signal reward_added
signal ad_closed
signal ad_error
signal ad_started
signal focused
signal unfocused


var _adCallbacks:JavaScriptObject
var _adRewardCallbacks:JavaScriptObject
var _adStartedCallback:JavaScriptObject
var _adErrorCallback:JavaScriptObject
var _adFinishedCallback:JavaScriptObject
var _adFinishedRewardCallback:JavaScriptObject
var _adRewardAndCloseCallback:JavaScriptObject


var window:JavaScriptObject

var YandexSDK:JavaScriptObject
var leaderboards:JavaScriptObject
var CrazySDK:JavaScriptObject
var GameDistSDK:JavaScriptObject
var PokiSDK:JavaScriptObject

var system_info := {}
var user_info := {}

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

enum Platform {YANDEX, CRAZY, GAMEDISTRIBUTION, POKI}

var platform : int

signal _inited


#region _ready
func _ready() -> void:
	match OS.get_name():
		"Web":
			window = JavaScriptBridge.get_interface("window")
			_set_pause_signal()
			_adCallbacks = JavaScriptBridge.create_object("Object")
			_adRewardCallbacks = JavaScriptBridge.create_object("Object")
			_adStartedCallback = JavaScriptBridge.create_callback(_adStarted)
			_adErrorCallback = JavaScriptBridge.create_callback(_adError)
			_adFinishedCallback = JavaScriptBridge.create_callback(_ad)
			_adFinishedRewardCallback = JavaScriptBridge.create_callback(_rewarded_ad)
			_adRewardAndCloseCallback = JavaScriptBridge.create_callback(_ad_reward_and_close)
			match window.platform:
				"yandex":
					platform = Platform.YANDEX
					system_info.platform = "yandex"
				"crazy":
					platform = Platform.CRAZY
					system_info.platform = "crazy"
				"gamedistribution":
					platform = Platform.GAMEDISTRIBUTION
					system_info.platform = "gamedistribution"
				"poki":
					platform = Platform.POKI
					system_info.platform = "poki"
				_:
					platform = -1
					system_info.platform = "unknowm"
					print("Unknown platform")
					return
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
					_SDK_inited.emit()
					print('gd init yandex')
				Platform.CRAZY:
					_adCallbacks["adFinished"] = _adFinishedCallback
					_adCallbacks["adError"] = _adErrorCallback
					_adCallbacks["adStarted"] = _adStartedCallback
					_adRewardCallbacks["adFinished"] = _adRewardAndCloseCallback
					_adRewardCallbacks["adError"] = _adErrorCallback
					_adRewardCallbacks["adStarted"] = _adStartedCallback
					print("waiting sdk..")
					CrazySDK = window.CrazyGames.SDK
					while not CrazySDK:
						CrazySDK = window.CrazyGames.SDK
						await get_tree().create_timer(0.1).timeout
					var callback_init = JavaScriptBridge.create_callback(func(args):
						_inited.emit())
					CrazySDK.init().then(callback_init)
					await _inited
					_SDK_inited.emit()
					print('gd init crazy')
				Platform.GAMEDISTRIBUTION:
					_adCallbacks["ad_stop"] = _adFinishedCallback
					_adCallbacks["ad_start"] = _adStartedCallback
					_adCallbacks["ad_rewarded"] = _adFinishedRewardCallback
					window.setcallbacks(_adCallbacks)
					GameDistSDK = window.gdsdk
					_SDK_inited.emit()
					print('gd init gamedistribution')
				Platform.POKI:
					var _callback = JavaScriptBridge.create_callback(func(args):
						_inited.emit()
					)
					print("waiting sdk..")
					PokiSDK = window.PokiSDK
					while not PokiSDK:
						PokiSDK = window.PokiSDK
						await get_tree().create_timer(0.1).timeout
					PokiSDK.init().then(_callback)
					await _inited
					_SDK_inited.emit()
					print('gd init poki')
			_get_info()
			_get_user_info()
				
				
func _get_info() -> void:
	var lang:String
	var type:String
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			lang = YandexSDK.environment.i18n.lang
			type = YandexSDK.deviceInfo.type
		Platform.CRAZY: 
			while not CrazySDK:
				await _SDK_inited
			var c_code = CrazySDK.user.systemInfo.countryCode
			lang = LANGUAGE_CODES[c_code]
			type = CrazySDK.user.systemInfo.device.type
		_:
			lang = "unknown"
			type = "unknown"
	system_info["language"] = lang
	system_info["device_type"] = type


signal _getted_player(player:JavaScriptObject)

var _callback_get_player = JavaScriptBridge.create_callback(func(args):
	_getted_player.emit(args[0])
	)

func _get_user_info():
	user_info.player_name = ""
	user_info.avatar = ""
	match platform:
		Platform.YANDEX:
			YandexSDK.getPlayer().then(_callback_get_player)
			var player = await _getted_player
			var name = player.getName()
			if name:
				user_info.player_name = name
				user_info.avatar = player.getPhoto("medium")
		Platform.CRAZY:
			if CrazySDK.user.isUserAccountAvailable:
				CrazySDK.user.getUser().then(_callback_get_player)
				var player = await _getted_player
				if player:
					user_info.player_name = player.username
					user_info.avatar = player.profilePictureUrl
	
	
var is_focus:bool = true
var _callback_w_p = JavaScriptBridge.create_callback(func(_args):
	unfocused.emit()
	is_focus = false
	)
var _callback_w_f = JavaScriptBridge.create_callback(func(_args):
	focused.emit()
	is_focus = true
	)
	
var document = JavaScriptBridge.get_interface("document")
var _listner = JavaScriptBridge.create_callback(func(_args):
	if document.hidden and is_focus:
		unfocused.emit()
	elif !document.hidden and !is_focus:
		focused.emit()
	is_focus = !is_focus
	)
	
func _set_pause_signal() -> void:
	window.addEventListener("focus", _callback_w_f)
	window.addEventListener("blur", _callback_w_p)
	
	document.addEventListener('visibilitychange', _listner)

#endregion
#region Ads
func show_ad() -> void:
	if OS.get_name() == "Web":
		match platform:
			Platform.CRAZY:
				crazy_show_ad()
			Platform.YANDEX:
				yandex_show_ad()
			Platform.GAMEDISTRIBUTION:
				game_dist_show_ad()
			Platform.POKI:
				poki_show_ad()
			_:
				push_warning("Platform not supported")
	else:
		push_warning("Not a web build")


func show_rewarded_ad()-> void:
	if OS.get_name() == "Web":
		match platform:
			Platform.CRAZY:
				crazy_show_rewarded_ad()
			Platform.YANDEX:
				yandex_show_rewarded_ad()
			Platform.GAMEDISTRIBUTION:
				game_dist_show_rewarded_ad()
			Platform.POKI:
				poky_show_rewarded_ad()
			_:
				push_warning("Platform not supported")
	else:
		push_warning("Not a web build")
	
# Yandex Games Block

func yandex_show_ad()-> void:
	while not YandexSDK:
		await _SDK_inited
	YandexSDK.adv.showFullscreenAdv(_adCallbacks)

func yandex_show_rewarded_ad()-> void:
	while not YandexSDK:
		await _SDK_inited
	YandexSDK.adv.showRewardedVideo(_adRewardCallbacks)

# Crazy Games

func crazy_show_ad()-> void:
	while not CrazySDK:
		await _SDK_inited
	CrazySDK.ad.requestAd("midgame", _adCallbacks)
	
func crazy_show_rewarded_ad()-> void:
	while not CrazySDK:
		await _SDK_inited
	CrazySDK.ad.requestAd("rewarded", _adRewardCallbacks)

# Game Distribution
func game_dist_show_ad()-> void:
	while not GameDistSDK:
		await _SDK_inited
	GameDistSDK.show_ad()
	
func game_dist_show_rewarded_ad()-> void:
	while not GameDistSDK:
		await _SDK_inited
	GameDistSDK.show_ad('rewarded')

# Poki

func poki_show_ad()-> void:
	while not PokiSDK:
		await _SDK_inited
	ad_started.emit()
	PokiSDK.commercialBreak().then(_adFinishedCallback)

var _poki_rewarded_ad = JavaScriptBridge.create_callback(_poki_reward_ad)

func poky_show_rewarded_ad()-> void:
	while not PokiSDK:
		await _SDK_inited
	ad_started.emit()
	PokiSDK.rewardedBreak().then(_poki_rewarded_ad)

func _poki_reward_ad(args)-> void:
	if args[0]:
		reward_added.emit()
	else:
		ad_error.emit()
	ad_closed.emit()

#Callbacks
func _rewarded_ad(args)-> void:
	reward_added.emit()
	
func _ad(args)-> void:
	ad_closed.emit()
	
func _adError(args)-> void:
	ad_error.emit()
	
func _adStarted(args)-> void:
	ad_started.emit()

func _ad_reward_and_close(args)-> void:
	reward_added.emit()
	ad_closed.emit()


func show_banner() -> void:
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
		_:
			push_warning("Platform not supported")
			return

		
func hide_banner() -> void:	
	match platform:
		Platform.YANDEX:
			YandexSDK.adv.hideBannerAdv()
		Platform.CRAZY:
			JavaScriptBridge.eval('document.getElementById("responsive-banner-container").style.display = "none"')
			CrazySDK.banner.clearBanner("responsive-banner-container")
		_:
			push_warning("Platform not supported")
			return
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
		Platform.POKI:
			while not PokiSDK:
				await _SDK_inited
			PokiSDK.gameplayStart()
		Platform.GAMEDISTRIBUTION:
			pass #TODO
		_:
			push_warning("Platform not supported")
			return


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
		Platform.POKI:
			while not PokiSDK:
				await _SDK_inited
			PokiSDK.gameplayStop()
		Platform.GAMEDISTRIBUTION:
			pass #TODO
		_:
			push_warning("Platform not supported")
			return
	


func ready():
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.features.LoadingAPI.ready()
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			CrazySDK.game.loadingStop()
		Platform.POKI:
			while not PokiSDK:
				await _SDK_inited
			PokiSDK.gameLoadingFinished()
		Platform.GAMEDISTRIBUTION:
			while not GameDistSDK:
				await _SDK_inited
			pass #TODO
		_:
			push_warning("Platform not supported")

			
#endregion
#region Yandex


signal leaderboard_info_recieved(result:Dictionary)
var _callback_info_recieved = JavaScriptBridge.create_callback(_leaderboard_info_recieved)

func get_leaderboard_info(leaderboard:String):
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			leaderboards.getLeaderboardDescription(leaderboard).then(_callback_info_recieved)
			return await leaderboard_info_recieved
		_:
			push_warning("Platform not supported")
			return

func _leaderboard_info_recieved(info):
	leaderboard_info_recieved.emit(_js_to_dict(info[0]))


signal leaderboard_score_setted

var _callback_leaderboard_score_setted = JavaScriptBridge.create_callback(func(args):
					leaderboard_score_setted.emit())

func set_leaderboard_score(leaderboard:String, score: int, extra_data:String = "") -> void:
	match platform:
		Platform.YANDEX:
			while not leaderboards:
				await _SDK_inited
			leaderboards.setLeaderboardScore(leaderboard, score, extra_data).then(_callback_leaderboard_score_setted)
			await leaderboard_score_setted
			return
		_:
			push_warning("Platform not supported")
			return


signal leaderboard_player_entry_recieved(result:Dictionary)
var callback_player_entry_recieved = JavaScriptBridge.create_callback(_leaderboard_player_entry_recieved)

func get_leaderboard_player_entry(leaderboard:String) -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			leaderboards.getLeaderboardPlayerEntry(leaderboard).then(callback_player_entry_recieved)
			return await leaderboard_player_entry_recieved
		_:
			push_warning("Platform not supported")
			return {}
		
func _leaderboard_player_entry_recieved(info) -> void:
	leaderboard_player_entry_recieved.emit(_js_to_dict(info[0]))


signal leaderboard_entries_recieved
var callback_entries_recieved = JavaScriptBridge.create_callback(_leaderboard_entries_recieved)

func get_leaderboard_entries(leaderboard:String, include_user:bool = true, quantity_around:int = 5, quantity_top:int = 5) -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			var config := JavaScriptBridge.create_object("Object")
			config["includeUser"] = include_user
			config["quantityAround"] = quantity_around
			config["quantityTop"] = quantity_top
			leaderboards.getLeaderboardEntries(leaderboard, config).then(callback_entries_recieved)
			return await leaderboard_entries_recieved
		_:
			push_warning("Platform not supported")
			return {}

func _leaderboard_entries_recieved(info):
	leaderboard_entries_recieved.emit(_js_to_dict(info[0]))


func get_server_time() -> int:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			return YandexSDK.serverTime()
		_:
			push_warning("Platform not supported")
			return 0


signal can_feedback(result:Dictionary)

var _callback_can_rewiew = JavaScriptBridge.create_callback(func(args):
	can_feedback.emit(_js_to_dict(args[0])))

func can_rewiew() -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.feedback.canReview().then(_callback_can_rewiew)
			return await can_feedback
		_:
			push_warning("Platform not supported")
			return {}


signal request_feedback(result:Dictionary)

var _callback_request_rewiew = JavaScriptBridge.create_callback(func(args):
	request_feedback.emit(_js_to_dict(args[0])))	

func request_review() -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.feedback.requestReview().then(_callback_request_rewiew)
			return await request_feedback
		_:
			push_warning("Platform not supported")
			return {}


signal could_show_prompt(result:Dictionary)

var _callback_can_show_prompt = JavaScriptBridge.create_callback(func(args):
	could_show_prompt.emit(_js_to_dict(args[0])))

func can_show_prompt() -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.feedback.canShowPrompt().then(_callback_can_show_prompt)
			return await could_show_prompt
		_:
			push_warning("Platform not supported")
			return {}

signal showed_prompt(result:Dictionary)

var callback_show_prompt = JavaScriptBridge.create_callback(func(args):
	showed_prompt.emit(_js_to_dict(args[0])))

func show_prompt() -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.feedback.showPrompt().then(callback_show_prompt)
			return await showed_prompt
		_:
			push_warning("Platform not supported")
			return {}


#endregion

#region Crazy Games
func happytime() -> void:
	match platform:
		Platform.CRAZY:
			if CrazySDK:
				CrazySDK.game.happytime()
			else:
				push_warning("SDK not initialized")
		_:
			push_warning("Platform not supported")
	
func start_loading() -> void:
	match platform:
		Platform.CRAZY:
			if CrazySDK:
				CrazySDK.game.loadingStart()
			else:
				push_warning("SDK not initialized")
		_:
			push_warning("Platform not supported")
				
#endregion
#region getting data

func get_platform() -> String:
	if OS.get_name() == "Web":
		match platform:
			Platform.YANDEX:
				return "yandex"
			Platform.CRAZY:
				return "crazy_games"
			Platform.GAMEDISTRIBUTION:
				return "game_distribution"
			Platform.POKI:
				return "poki"
			_:
				return "unknown"
	return "unknown"


func get_language() -> String:
	if OS.get_name() == "Web":
		if system_info:
			print("language from sdk:", system_info["language"])
			return system_info["language"]
		return "unknown"
	return "unknown"


func get_type_device() -> String:
	if OS.get_name() == "Web":
		if system_info:
			print("type device from sdk:", system_info["device_type"])
			return system_info["device_type"]
		return "unknown"
	return "unknown"

#endregion

#region invite

signal invite_link_getted(result:String)

func invite_link(params:Dictionary) -> String:
	var conf = JavaScriptBridge.create_object("Object")
	for key in params.keys():
		conf[key] = params[key]
	match platform:
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			return CrazySDK.game.inviteLink(conf)
		Platform.POKI:
			while not PokiSDK:
				await _SDK_inited
			var callback = JavaScriptBridge.create_callback(func(args):
				invite_link_getted.emit(args[0]))
			PokiSDK.shareableURL(conf).then(callback)
			return await invite_link_getted
		_:
			push_warning("Platform not supported")
			return ""


func get_invite_param(param:Variant) -> Variant:
	match platform:
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			return CrazySDK.game.getInviteParam(param)
		Platform.POKI:
			while not PokiSDK:
				await _SDK_inited
			return PokiSDK.getURLParam(param)
		_:
			push_warning("Platform not supported")
			return ""


func show_invite_button(params:Dictionary) -> void:
	var conf = JavaScriptBridge.create_object("Object")
	for key in params.keys():
		conf[key] = params[key]
	match platform:
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			CrazySDK.game.showInviteButton(conf)
		_:
			push_warning("Platform not supported")

func hide_invite_button() -> void:
	match platform:
		Platform.CRAZY:
			while not CrazySDK:
				await _SDK_inited
			CrazySDK.game.hideInviteButton()
		_:
			push_warning("Platform not supported")


#endregion

#region purchases
var payments:JavaScriptObject

var _init_payments_callback := JavaScriptBridge.create_callback(func(args):
	payments = args[0]
	payments_inited.emit())

signal payments_inited

func init_payments(signed:bool = false) -> void:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			var conf := JavaScriptBridge.create_object("Object")
			if signed:
				conf["signed"] = signed
			YandexSDK.getPayments(conf).then(_init_payments_callback)
			await payments_inited
		_:
			push_warning("Platform not supported")


signal purchased(success:bool)

var _purchase_callback := JavaScriptBridge.create_callback(func(args):
	purchased.emit(true))

var _purchase_error_callback := JavaScriptBridge.create_callback(func(args):
	print("Error purchase", _js_to_dict(args[0]))
	purchased.emit(false))

func purchase(id:String, developer_payload:String = "") -> bool:
	match platform:
		Platform.YANDEX:
			var settings := JavaScriptBridge.create_object("Object")
			settings["id"] = id
			if developer_payload:
				settings["developerPayload"] = developer_payload
			if payments:
				payments.purchase(settings).then(_purchase_callback).catch(_purchase_error_callback)
				return await purchased
			return false
		_:
			push_warning("Platform not supported")
			return false
	


signal purchase_getted(success:bool)

var _get_purchases_callback := JavaScriptBridge.create_callback(func(args):
	purchase_getted.emit(_js_to_dict(args[0])))

var _get_purchases_error_callback := JavaScriptBridge.create_callback(func(args):
	push_warning(_js_to_dict(args[0]))
	purchase_getted.emit([]))

func get_purchases() -> Array:
	match platform:
		Platform.YANDEX:
			if payments:
				payments.getPurchases().then(_get_purchases_callback).catch(_get_purchases_error_callback)
				return await purchase_getted
			return []
		_:
			push_warning("Platform not supported")
			return []


signal catalog_getted(success:bool)

var _get_catalog_callback := JavaScriptBridge.create_callback(func(args):
	catalog_getted.emit(_js_to_dict(args[0])))

var _get_catalog_error_callback := JavaScriptBridge.create_callback(func(args):
	push_warning(_js_to_dict(args[0]))
	catalog_getted.emit([]))

func get_catalog() -> Array:
	match platform:
		Platform.YANDEX:
			if payments:
				payments.getCatalog().then(_get_catalog_callback).catch(_get_catalog_error_callback)
				return await catalog_getted
			return []
		_:
			push_warning("Platform not supported")
			return []


#endregion
#region tool

func _js_to_dict(js_object:JavaScriptObject) -> Variant:
	var window := JavaScriptBridge.get_interface("window")
	var strn = window.JSON.stringify(js_object).to_snake_case()
	return JSON.parse_string(strn)
	
#endregion
