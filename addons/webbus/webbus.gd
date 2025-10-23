extends Node
## Singlton class[br]
## [br]
## Docs: [url]https://talkafk.github.io/WebBus[/url]


signal inited
signal _SDK_inited
signal reward_added
signal ad_closed
signal ad_error
signal ad_started
signal focused
signal unfocused

signal _inited

var is_init:bool = false

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
var vkBridge:JavaScriptObject

var system_info := {}
var user_info := {}

enum Platform {YANDEX, CRAZY, GAMEDISTRIBUTION, POKI, VK}

var platform : int

var tools := WebBusTools.new()

var platform_sdk : WBPlatform

#region _ready
func _ready() -> void:
	match OS.get_name():
		"Web":
			window = JavaScriptBridge.get_interface("window")
			_set_pause_signal()
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
				"vk":
					platform = Platform.VK
					system_info.platform = "vk"
				_:
					platform = -1
					system_info.platform = "unknowm"
					print("Unknown platform")
					return
			match platform:
				Platform.YANDEX:
					print('waiting sdk..')
					platform_sdk = WBPlatformYandex.new()
				Platform.CRAZY:
					pass
				Platform.GAMEDISTRIBUTION:
					pass
				Platform.POKI:
					pass
				Platform.VK:
					pass
				platform_sdk.init_platform()
				_SDK_inited.emit()
				print('gd init')
			await _get_info()
			await _get_user_info()
			is_init = true
			inited.emit()
				
				
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
			var c_code :String = CrazySDK.user.systemInfo.countryCode
			lang = tools.get_language_by_code(c_code)
			type = CrazySDK.user.systemInfo.device.type
		_:
			lang = "unknown"
			type = "unknown"
	system_info["language"] = lang
	system_info["device_type"] = type


signal _getted_player(player:JavaScriptObject)

var _callback_get_player := JavaScriptBridge.create_callback(func(args):
	_getted_player.emit(args[0])
	)
var js_player:JavaScriptObject


func _get_user_info():
	user_info.player_name = ""
	user_info.avatar = ""
	match platform:
		Platform.YANDEX:
			YandexSDK.getPlayer().then(_callback_get_player)
			js_player = await _getted_player
			var name = js_player.getName()
			if name:
				user_info.player_name = name
				user_info.avatar = js_player.getPhoto("medium")
				user_info.is_auth = js_player.isAuthorized()
		Platform.CRAZY:
			if CrazySDK.user.isUserAccountAvailable:
				CrazySDK.user.getUser().then(_callback_get_player)
				js_player = await _getted_player
				if js_player:
					user_info.player_name = js_player.username
					user_info.avatar = js_player.profilePictureUrl
		Platform.VK:
			vkBridge.send("VKWebAppGetUserInfo").then(_callback_get_player)
			js_player = await _getted_player
			if js_player:
				user_info.player_name = js_player.first_name + " " + js_player.last_name
				user_info.avatar = js_player.photo_100
	
	
var is_focus:bool = true
var _callback_w_p := JavaScriptBridge.create_callback(func(_args):
	unfocused.emit()
	is_focus = false
	)
var _callback_w_f := JavaScriptBridge.create_callback(func(_args):
	focused.emit()
	is_focus = true
	)
	
var document := JavaScriptBridge.get_interface("document")
var _listner := JavaScriptBridge.create_callback(func(_args):
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
## Calling full-screen advertisement[br]
## Supported platform: [br]
## Crazy Games  ✔️[br]
## Yandex Games  ✔️[br]
## Poki  ✔️[br]
## VK  ✔️[br]
## Docs: [url]https://github.com/talkafk/WebBus?tab=readme-ov-file#advertisement[/url]
func show_ad() -> void:
	_call_method_on_platform("show_ad")


## Calling rewarded advertisement[br]
## Supported platform: [br]
## Crazy Games  ✔️[br]
## Yandex Games  ✔️[br]
## Poki  ✔️[br]
## VK  ✔️[br]
## Docs: [url]https://github.com/talkafk/WebBus?tab=readme-ov-file#advertisement[/url]
func show_rewarded_ad()-> void:
	_call_method_on_platform("show_rewarded_ad")


func _call_method_on_platform(method_name: String) -> void:
	if OS.get_name() == "Web":
		if platform_sdk.has_method(method_name):
			platform_sdk.call(method_name)
			return
		push_warning("Platform not supported")
	else:
		push_warning("Not a web build")


#Callbacks
func _rewarded_ad(args) -> void:
	reward_added.emit()
	
func _ad(args) -> void:
	ad_closed.emit()
	
func _adError(args) -> void:
	push_error("WebBus error:", tools.js_to_dict(args[0]))
	ad_error.emit()
	
func _adStarted(args) -> void:
	ad_started.emit()

func _ad_reward_and_close(args) -> void:
	reward_added.emit()
	ad_closed.emit()

var _reward_check_ad_callback := JavaScriptBridge.create_callback(_reward_check_ad)

func _reward_check_ad(args) -> void:
	if args[0]:
		reward_added.emit()
	else:
		ad_error.emit()
	ad_closed.emit()
	
var _vk_ad_callback := JavaScriptBridge.create_callback(_vk_ad_result)
var _vk_reward_callback := JavaScriptBridge.create_callback(_vk_reward_result)

func _vk_ad_result(args) -> void:
	if args[0].result:
		ad_closed.emit()
	else:
		_adError(args)
		ad_closed.emit()

func _vk_reward_result(args) -> void:
	if args[0].result:
		reward_added.emit()
	else:
		_adError(args)
	ad_closed.emit()


## Calling banner advertisement [br]
## Supported platform: [br]
## Crazy Games  ✔️[br]
## Yandex Games  ✔️[br]
## Poki  ❌[br]
## VK  ✔️[br]
## Docs: [url]https://github.com/talkafk/WebBus?tab=readme-ov-file#advertisement[/url]
func show_banner() -> void:
	_call_method_on_platform("show_banner")

## Hidding banner advertisement [br]
## Supported platform: [br]
## Crazy Games  ✔️[br]
## Yandex Games  ✔️[br]
## Poki  ❌[br]
## VK  ✔️[br]
## Docs: [url]https://github.com/talkafk/WebBus?tab=readme-ov-file#advertisement[/url]
func hide_banner() -> void:	
	_call_method_on_platform("hide_banner")

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
		Platform.VK:
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
		Platform.VK:
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
		Platform.VK:
			push_warning("Platform not supported")
		_:
			push_warning("Platform not supported")

			
#endregion

#region Data
signal _auth(success:bool)

var _callback_auth_dialog := JavaScriptBridge.create_callback(func(args):
	_auth.emit(true)
	)
	
var _callback_auth_dialog_error := JavaScriptBridge.create_callback(func(args):
	_auth.emit(false)
	)

func open_auth_dialog() -> bool:
	if OS.get_name() == "Web":
		match platform:
			Platform.YANDEX:
				YandexSDK.auth.openAuthDialog().then(_callback_auth_dialog).catch(_callback_auth_dialog_error)
				var result = await _auth
				if result:
					YandexSDK.getPlayer().then(_callback_get_player)
					js_player = await _getted_player
					var name = js_player.getName()
					if name:
						user_info.player_name = name
						user_info.avatar = js_player.getPhoto("medium")
						user_info.is_auth = js_player.isAuthorized()
				return result
			Platform.CRAZY:
				CrazySDK.user.showAuthPrompt().then(_callback_auth_dialog).catch(_callback_auth_dialog_error)
				var result = await _auth
				if result and CrazySDK.user.isUserAccountAvailable:
					CrazySDK.user.getUser().then(_callback_get_player)
					js_player = await _getted_player
					if js_player:
						user_info.player_name = js_player.username
						user_info.avatar = js_player.profilePictureUrl
				return result
			_:
				push_warning("Platform not supported")
	return false
	
	
func set_data(data:Dictionary) -> void:
	if OS.get_name() == "Web":
		match platform:
			Platform.YANDEX:
				var _data:JavaScriptObject = tools.to_js(data)
				js_player.setData(_data)
			Platform.CRAZY:
				for k in data:
					CrazySDK.data.setItem(k, data[k])
			_:
				push_warning("Platform not supported")
						

signal _getted_data

var _callback_getting_data := JavaScriptBridge.create_callback(func(args):
	_getted_data.emit(tools.js_to_dict(args[0], false))
	)
	
var _callback_getting_data_error := JavaScriptBridge.create_callback(func(args):
	push_error("WebBus error:", tools.js_to_dict(args[0]))
	_getted_data.emit({})
	)

func get_data(keys:Variant) -> Dictionary:
	var keys_array:Array
	if keys is Array:
		keys_array = keys
	else:
		keys_array = [keys]
		
	var result := {}
	if OS.get_name() == "Web":
		match platform:
			Platform.YANDEX:
				var _data:JavaScriptObject = tools.to_js(keys_array)
				js_player.getData(_data).then(_callback_getting_data).catch(_callback_getting_data_error)
				result = await _getted_data
				return result
			Platform.CRAZY:
				for k in keys_array:
					result[k] = CrazySDK.data.getItem(k)
				return result
			_:
				push_warning("Platform not supported")
	return result
	
	
func set_stats(data:Dictionary) -> void:
	if OS.get_name() == "Web":
		match platform:
			Platform.YANDEX:
				var _data:JavaScriptObject = tools.to_js(data)
				js_player.setStats(_data)
			Platform.CRAZY:
				for k in data:
					CrazySDK.data.setItem(k, data[k])
			_:
				push_warning("Platform not supported")
						

signal _getted_stats

var _callback_getting_stats := JavaScriptBridge.create_callback(func(args):
	_getted_stats.emit(tools.js_to_dict(args[0], false))
	)
	
var _callback_getting_stats_error := JavaScriptBridge.create_callback(func(args):
	push_error("WebBus error:", tools.js_to_dict(args[0]))
	_getted_stats.emit({})
	)

func get_stats(keys:Variant) -> Dictionary:
	var keys_array:Array
	if keys is Array:
		keys_array = keys
	else:
		keys_array = [keys]
		
	var result := {}
	if OS.get_name() == "Web":
		match platform:
			Platform.YANDEX:
				var _data:JavaScriptObject = tools.to_js(keys_array)
				js_player.getStats(_data).then(_callback_getting_stats).catch(_callback_getting_stats_error)
				result = await _getted_stats
				return result
			Platform.CRAZY:
				for k in keys_array:
					result[k] = CrazySDK.data.getItem(k)
				return result
			_:
				push_warning("Platform not supported")
	return result
#endregion
#region Yandex

signal leaderboard_info_recieved(result:Dictionary)
var _callback_info_recieved := JavaScriptBridge.create_callback(_leaderboard_info_recieved)

func get_leaderboard_info(leaderboard:String):
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			leaderboards.getDescription(leaderboard).then(_callback_info_recieved)
			return await leaderboard_info_recieved
		_:
			push_warning("Platform not supported")
			return

func _leaderboard_info_recieved(info):
	leaderboard_info_recieved.emit(tools.js_to_dict(info[0]))


signal leaderboard_score_setted

var _callback_leaderboard_score_setted := JavaScriptBridge.create_callback(func(args):
					leaderboard_score_setted.emit())

func set_leaderboard_score(leaderboard:String, score: int, extra_data:String = "") -> void:
	match platform:
		Platform.YANDEX:
			while not leaderboards:
				await _SDK_inited
			leaderboards.setScore(leaderboard, score, extra_data).then(_callback_leaderboard_score_setted)
			await leaderboard_score_setted
			return
		_:
			push_warning("Platform not supported")
			return


signal leaderboard_player_entry_recieved(result:Dictionary)
var _callback_player_entry_recieved := JavaScriptBridge.create_callback(_leaderboard_player_entry_recieved)

func get_leaderboard_player_entry(leaderboard:String) -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			leaderboards.getPlayerEntry(leaderboard).then(_callback_player_entry_recieved)
			return await leaderboard_player_entry_recieved
		_:
			push_warning("Platform not supported")
			return {}
		
func _leaderboard_player_entry_recieved(info) -> void:
	leaderboard_player_entry_recieved.emit(tools.js_to_dict(info[0]))


signal leaderboard_entries_recieved
var _callback_entries_recieved := JavaScriptBridge.create_callback(_leaderboard_entries_recieved)

func get_leaderboard_entries(leaderboard:String, include_user:bool = true, quantity_around:int = 5, quantity_top:int = 5) -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			var config := JavaScriptBridge.create_object("Object")
			config["includeUser"] = include_user
			config["quantityAround"] = quantity_around
			config["quantityTop"] = quantity_top
			leaderboards.getEntries(leaderboard, config).then(_callback_entries_recieved)
			return await leaderboard_entries_recieved
		_:
			push_warning("Platform not supported")
			return {}

func _leaderboard_entries_recieved(info):
	leaderboard_entries_recieved.emit(tools.js_to_dict(info[0]))


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

var _callback_can_rewiew := JavaScriptBridge.create_callback(func(args):
	can_feedback.emit(tools.js_to_dict(args[0])))

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

var _callback_request_rewiew := JavaScriptBridge.create_callback(func(args):
	request_feedback.emit(tools.js_to_dict(args[0])))	

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

var _callback_can_show_prompt := JavaScriptBridge.create_callback(func(args):
	could_show_prompt.emit(tools.js_to_dict(args[0])))

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

var _callback_show_prompt := JavaScriptBridge.create_callback(func(args):
	showed_prompt.emit(tools.js_to_dict(args[0])))

func show_prompt() -> Dictionary:
	match platform:
		Platform.YANDEX:
			while not YandexSDK:
				await _SDK_inited
			YandexSDK.feedback.showPrompt().then(_callback_show_prompt)
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
		if !system_info.is_empty():
			return system_info.get("language", "unknown")
		return "unknown"
	return "unknown"


func get_type_device() -> String:
	if OS.get_name() == "Web":
		if !system_info.is_empty():
			return system_info.get("device_type", "unknown")
		return "unknown"
	return "unknown"

#endregion

#region invite

signal invite_link_getted(result:String)

func invite_link(params:Dictionary) -> String:
	var conf := JavaScriptBridge.create_object("Object")
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
			var callback := JavaScriptBridge.create_callback(func(args):
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
	var conf := JavaScriptBridge.create_object("Object")
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


signal purchased(data:Dictionary)

var _purchase_callback := JavaScriptBridge.create_callback(func(args):
	purchased.emit(tools.js_to_dict(args[0]))
	)

var _purchase_error_callback := JavaScriptBridge.create_callback(func(args):
	var message:String
	if args[0].code == "payment_user_canceled":
		message = "Payment user canceled"
	else:
		message = tools.js_to_dict(args[0])
	purchased.emit({"error": true, "message": message})
	)


func purchase(id:String, developer_payload:String = "") -> Dictionary:
	match platform:
		Platform.YANDEX:
			var settings := JavaScriptBridge.create_object("Object")
			settings["id"] = id
			if developer_payload:
				settings["developerPayload"] = developer_payload
			if payments:
				payments.purchase(settings).then(_purchase_callback).catch(_purchase_error_callback)
				return await purchased
			return ({"error": true,  "message": "Payments not initialized"})
		_:
			push_warning("Platform not supported")
			return {"error": true, "message": "Platform not supported"}


signal purchases_getted(list:Array)

var _get_purchases_callback := JavaScriptBridge.create_callback(func(args):
	purchases_getted.emit(tools.js_to_dict(args[0])))

var _get_purchases_error_callback := JavaScriptBridge.create_callback(func(args):
	push_warning(tools.js_to_dict(args[0]))
	purchases_getted.emit([]))

func get_purchases() -> Array:
	match platform:
		Platform.YANDEX:
			if payments:
				payments.getPurchases().then(_get_purchases_callback).catch(_get_purchases_error_callback)
				return await purchases_getted
			return []
		_:
			push_warning("Platform not supported")
			return []


signal catalog_getted(list:Array)

var _get_catalog_callback := JavaScriptBridge.create_callback(func(args):
	catalog_getted.emit(tools.js_to_dict(args[0])))

var _get_catalog_error_callback := JavaScriptBridge.create_callback(func(args):
	push_warning(tools.js_to_dict(args[0]))
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


signal consumed(succes:bool)

var _consume_callback := JavaScriptBridge.create_callback(func(args):
	consumed.emit(args[0])
	)
	
var _consume_error_callback := JavaScriptBridge.create_callback(func(args):
	push_warning(tools.js_to_dict(args[0]))
	consumed.emit(false)
	)

func consume_purchase(token:String) -> bool:
	match platform:
		Platform.YANDEX:
			if payments:
				payments.consumePurchase(token).then(_consume_callback).catch(_consume_error_callback)
				return await consumed
		_:
			push_warning("Platform not supported")
	return false
	
#endregion
