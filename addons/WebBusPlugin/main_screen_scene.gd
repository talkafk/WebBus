@tool
extends Control

var crazy_banner_w := 728
var crazy_banner_h := 90

signal main_scene_data_change


func _on_spin_box_value_changed(value):
	crazy_banner_w = value
	main_scene_data_change.emit()


func _on_spin_box_2_value_changed(value):
	crazy_banner_h = value
	main_scene_data_change.emit()
