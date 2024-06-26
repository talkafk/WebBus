@tool
extends EditorPlugin

const  AUTOLOAD_NAME_AD = "WebBus"

var export_plugin: HTMLExportPlugin

const MainScreenScene = preload("res://addons/WebBusPlugin/MainScreenScene.tscn")
var main_screen_scene_instance

func _enter_tree():
	# Initialization of the plugin goes here.
	add_autoload_singleton(AUTOLOAD_NAME_AD, "res://addons/WebBusPlugin/WebBus.gd")
	export_plugin = load("res://addons/WebBusPlugin/export_plugin.gd").new()
	add_export_plugin(export_plugin)
	main_screen_changed.connect(_update_data_from_main_screen)
	
	# Init main screen scene
	main_screen_scene_instance = MainScreenScene.instantiate()
	EditorInterface.get_editor_main_screen().add_child(main_screen_scene_instance)
	_make_visible(false)


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_autoload_singleton(AUTOLOAD_NAME_AD)
	remove_export_plugin(export_plugin)


func _has_main_screen():
	return true


func _make_visible(visible):
	if main_screen_scene_instance:
		main_screen_scene_instance.visible = visible


func _get_plugin_name():
	return "WebBus"


func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
	

func _update_data_from_main_screen(_screen_name):
	if _screen_name == _get_plugin_name():
		export_plugin.crazy_banner_w = main_screen_scene_instance.crazy_banner_w
		export_plugin.crazy_banner_h = main_screen_scene_instance.crazy_banner_h
