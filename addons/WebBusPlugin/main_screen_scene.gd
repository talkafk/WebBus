@tool
extends Control

var crazy_banner_w := "728px"
var crazy_banner_h := "90px"
var crazy_banner_pos := "bottom"
var archive_name := "export.zip"
var is_archive :bool = false

signal main_scene_data_change

func _ready() -> void:
	_load_config()
	main_scene_data_change.emit()


func _save_config() -> void:
	var config = ConfigFile.new()
	config.set_value("config", "crazy_banner_w", crazy_banner_w)
	config.set_value("config", "crazy_banner_h", crazy_banner_h)
	config.set_value("config", "crazy_banner_pos", crazy_banner_pos)
	config.set_value("config", "archive_name", archive_name)
	config.set_value("config", "is_archive", is_archive)
	
	config.save("res://.webbus_settings.cfg")


func _load_config() -> void:
	var config = ConfigFile.new()
	var err = config.load("res://.webbus_settings.cfg")
	if err != OK:
		_save_config()
		return
	crazy_banner_w = config.get_value("config", "crazy_banner_w")
	crazy_banner_h = config.get_value("config", "crazy_banner_h")
	crazy_banner_pos = config.get_value("config", "crazy_banner_pos")
	archive_name = config.get_value("config", "archive_name")
	is_archive = config.get_value("config", "is_archive")
	$"MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/Is Archive".button_pressed = is_archive
	$MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/yandex_archive_name.text = archive_name
	var id_pos:int
	match crazy_banner_pos:
		"bottom":
			id_pos = 0
		"top":
			id_pos = 1
		"left":
			id_pos = 2
		"right":
			id_pos = 3
	$MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerPos/crazy_banner_pos.select(id_pos)
	for i in range($MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_w.item_count):
		if crazy_banner_w == $MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_w.get_item_text(i):
			$MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_w.select(i)
	for i in range($MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_h.item_count):
		if crazy_banner_h == $MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_h.get_item_text(i):
			$MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_h.select(i)


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
	_save_config()


func _on_crazy_banner_w_item_selected(index):
	crazy_banner_w = $MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_w.get_item_text(index)
	main_scene_data_change.emit()
	_save_config()


func _on_crazy_banner_h_item_selected(index):
	crazy_banner_h = $MarginContainer/HBoxContainer/VBoxContainer/CrazyBannerSize/crazy_banner_h.get_item_text(index)
	main_scene_data_change.emit()
	_save_config()


func _on_is_archive_toggled(toggled_on:bool):
	is_archive = toggled_on
	main_scene_data_change.emit()
	_save_config()


func _on_yandex_archive_name_text_changed(new_text: String) -> void:
	if new_text.ends_with(".zip"):
		archive_name = new_text
	else:
		archive_name = new_text + ".zip"
	main_scene_data_change.emit()
	_save_config()
