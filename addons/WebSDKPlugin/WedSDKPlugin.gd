@tool
extends EditorPlugin

const  AUTOLOAD_NAME_AD = "WebSDK"

var export_plugin: HTMLExportPlugin

func _enter_tree():
	# Initialization of the plugin goes here.
	add_autoload_singleton(AUTOLOAD_NAME_AD, "res://addons/WebSDKPlugin/WebSDK.gd")
	export_plugin = load("res://addons/WebSDKPlugin/export_plugin.gd").new()
	add_export_plugin(export_plugin)


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_autoload_singleton(AUTOLOAD_NAME_AD)
	remove_export_plugin(export_plugin)

