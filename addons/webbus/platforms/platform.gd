extends Node
class_name WBPlatform


signal _inited
signal inited


var window:JavaScriptObject


func _init() -> void:
	match OS.get_name():
		"Web":
			window = JavaScriptBridge.get_interface("window")
