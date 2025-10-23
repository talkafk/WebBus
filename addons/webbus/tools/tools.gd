class_name WebBusTools extends RefCounted


func js_to_dict(js_object:JavaScriptObject, is_snake:bool=true) -> Variant:
	var window := JavaScriptBridge.get_interface("window")
	var strn = window.JSON.stringify(js_object)
	var dict = JSON.parse_string(strn)
	if is_snake:
		return _re_snake(dict)
	return dict


func _re_snake(data:Variant) -> Variant:
	var new_data = data
	if data is Dictionary:
		new_data = {}
		for k in data:
			if k is String:
				var k_snake = k.to_snake_case()
				new_data[k_snake] = _re_snake(data[k])
			else:
				new_data[k] = _re_snake(data[k])
	elif data is Array:
		new_data = []
		for e in data:
			new_data.append(_re_snake(e))
	elif data is float:
		if data == int(data):
			new_data = int(data)
	return new_data
	
	
func to_js(data:Variant) -> Variant:
	if data is Dictionary:
		var js_object = JavaScriptBridge.create_object("Object")
		for k in data:
			js_object[k] = to_js(data[k])
		return js_object
	if data is Array:
		var js_object = JavaScriptBridge.create_object("Array")
		for k in data:
			js_object.push(to_js(k))
		return js_object
	return data
	

func get_language_by_code(code:String) -> String:
	var file = FileAccess.open("res://addons/webbus/tools/language_codes.json", FileAccess.READ)
	var code_dict:Dictionary = JSON.parse_string(file.get_as_text())
	file.close()
	return code_dict[code]


class VKRequest:
	var callback:Callable
	var params:Dictionary
	var event:String
	
	var tools := WebBusTools.new()
	
	var result_callback := JavaScriptBridge.create_callback(func(args):
		if args[0]:
			callback.call(tools.js_to_dict(args[0]))
		else:
			push_error("Error vk request")
	)

	var send_callback := JavaScriptBridge.create_callback(func(args):
		if args[0]:
			if params:
				var _conf := tools.to_js(params)
				WebBus.vkBridge.send(event, _conf).then(result_callback)
			else:
				WebBus.vkBridge.send(event).then(result_callback)
		else:
			push_error("Error vk request")
		)

	func send(_event:String, _params:Dictionary={}, _callback:Callable=_callback_pass):
		if OS.get_name() == "Web" and WebBus.platform == WebBus.Platform.VK:
			params = _params
			callback = _callback
			event = _event
			WebBus.vkBridge.supportsAsync(event).then(send_callback)
		else:
			push_warning("Platform not supported")
	
	func _callback_pass(data:Variant) -> void:
		pass
		
	
