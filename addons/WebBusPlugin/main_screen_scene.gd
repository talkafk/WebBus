@tool
extends Control

var crazy_banner_w := "728px"
var crazy_banner_h := "90px"
var crazy_banner_pos := "bottom"

signal main_scene_data_change


func _on_crazy_banner_pos_item_selected(index):
	match index:
		0:
			crazy_banner_pos = "bottom"
		1:
			crazy_banner_pos = "top"
		2:
			crazy_banner_pos = "left"
		3:
			crazy_banner_pos = "right"
	main_scene_data_change.emit()


func _on_crazy_banner_w_item_selected(index):
	crazy_banner_w = $MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_w.get_item_text(index)
	main_scene_data_change.emit()


func _on_crazy_banner_h_item_selected(index):
	crazy_banner_h = $MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_h.get_item_text(index)
	main_scene_data_change.emit()
