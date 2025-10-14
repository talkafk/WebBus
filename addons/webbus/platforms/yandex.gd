extends WBPlatform
class_name WBYandexPlatform

var YandexSDK:JavaScriptObject
var leaderboards:JavaScriptObject


var _adCallbacks:JavaScriptObject
var _adRewardCallbacks:JavaScriptObject


func init_platform(ad_callbacks:JavaScriptObject, reward_callbacks:JavaScriptObject) -> void:
	var window = JavaScriptBridge.get_interface("window")
	_adCallbacks = ad_callbacks
	_adRewardCallbacks = reward_callbacks
	print('waiting sdk..')
	while not window.YaGames:
		await get_tree().create_timer(0.1).timeout
	var _init_callback := JavaScriptBridge.create_callback(func(args):
		YandexSDK = args[0]
		leaderboards = YandexSDK.leaderboards
		if OS.is_debug_build():
			window.ysdk = YandexSDK
		_inited.emit()
		)
	window.YaGames.init().then(_init_callback)
	await _inited
	inited.emit()
	print('gd init yandex')

func show_ad()-> void:
	while not YandexSDK:
		await _inited
	YandexSDK.adv.showFullscreenAdv(_adCallbacks)

func show_rewarded_ad()-> void:
	while not YandexSDK:
		await _inited
	YandexSDK.adv.showRewardedVideo(_adRewardCallbacks)
