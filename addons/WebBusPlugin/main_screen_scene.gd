@tool
extends Control

var crazy_banner_w := "728px"
var crazy_banner_h := "90px"
var crazy_banner_pos := "bottom"
var yandex_archive_name := "yandex_export.zip"
var is_archive :bool = false

signal main_scene_data_change

func test_func() -> void:
	pass

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


func _on_yandex_archive_name_text_submitted(new_text:String):
	if new_text.ends_with(".zip"):
		yandex_archive_name = new_text
	else:
		yandex_archive_name = new_text + ".zip"
	main_scene_data_change.emit()


func _on_is_archive_toggled(toggled_on:bool):
	is_archive = toggled_on
	main_scene_data_change.emit()
