extends WBPlatform
class_name WBVKPlatform


var vkBridge:JavaScriptObject

func init_platform(ad_callbacks:JavaScriptObject, reward_callbacks:JavaScriptObject) -> void:
	var _callback := JavaScriptBridge.create_callback(func(args):
		if args[0].result:
			_inited.emit()
		else:
			push_error("Error vk init")
	)
	vkBridge = window.vkBridge
	while not vkBridge:
		vkBridge = window.vkBridge
		await get_tree().create_timer(0.1).timeout
	vkBridge.send("VKWebAppInit").then(_callback)
	await _inited
	inited.emit()
	print('gd init vk')
