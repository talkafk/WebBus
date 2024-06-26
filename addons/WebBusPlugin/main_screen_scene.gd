@tool
extends Control

var crazy_banner_w := 728
var crazy_banner_h := 90

func _on_option_button_item_selected(index):
	match index:
		0:
			crazy_banner_w = 728
			crazy_banner_h = 90
		1:
			crazy_banner_w = 300
			crazy_banner_h = 250
		2:
			crazy_banner_w = 320
			crazy_banner_h = 50
		3:
			crazy_banner_w = 468
			crazy_banner_h = 60
		4:
			crazy_banner_w = 320
			crazy_banner_h = 100
