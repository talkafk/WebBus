extends Control

func _ready():
	if !WebBus.is_init:
		await WebBus.inited
	print(WebBus.get_language())
	WebBus.ad_closed.connect(ad_closed)
	WebBus.ad_error.connect(ad_error)
	WebBus.ad_started.connect(ad_started)
	WebBus.reward_added.connect(reward_added)
	WebBus.leaderboard_info_recieved.connect(getting_leaderboard_info)
	WebBus.leaderboard_player_entry_recieved.connect(getting_leaderboard_player_entry)
	WebBus.leaderboard_entries_recieved.connect(getting_leaderboard_entries)
	WebBus.focused.connect(func():
		get_tree().set_pause(false)
		AudioServer.set_bus_mute(0, false))
	WebBus.unfocused.connect(func():
		get_tree().set_pause(true)
		AudioServer.set_bus_mute(0, true))

func _on_show_ad_pressed():
	WebBus.show_ad()


func _on_show_reward_ad_pressed():
	WebBus.show_rewarded_ad()


func _on_show_banner_pressed():
	WebBus.show_banner()


func _on_hide_banner_pressed():
	WebBus.hide_banner()


func _on_get_language_pressed():
	var lang = WebBus.get_language()
	print("language:", lang)
	

func _on_get_type_device_pressed():
	var type = WebBus.get_type_device()
	print("device type:", type)	


func _on_set_yandex_leaderboard_pressed():
	var name_leaderboard :String = $VBoxContainer/Yandex/HBoxContainer2/leaderboard.text
	var score: int = int($VBoxContainer/Yandex/HBoxContainer2/score.text)
	WebBus.set_leaderboard_score(name_leaderboard, score)
	
func _on_ready_pressed():
	WebBus.ready()

func ad_closed():
	AudioServer.set_bus_mute(0, false)
	print("ad_closed")
	
func ad_error():
	print("ad_error")
	
func ad_started():
	AudioServer.set_bus_mute(0, true)
	print("ad_started")
	
func reward_added():
	print("reward_added")


var leaderboard_info

func _on_get_yandex_leaderboard_info_pressed():
	var name_leaderboard :String = $VBoxContainer/Yandex/HBoxContainer/leaderboard.text
	WebBus.get_leaderboard_info(name_leaderboard)
	
	
func getting_leaderboard_info(info):
	print(info)

func _on_get_yandex_leaderboard_player_entry_pressed():
	var name_leaderboard :String = $VBoxContainer/Yandex/HBoxContainer3/leaderboard.text
	WebBus.get_leaderboard_player_entry(name_leaderboard)

func getting_leaderboard_player_entry(info):
	print(info)
	
	
func _on_get_yandex_leaderboard_entries_pressed():
	var name_leaderboard :String = $VBoxContainer/Yandex/HBoxContainer4/leaderboard.text
	WebBus.get_leaderboard_entries(name_leaderboard)
	
func getting_leaderboard_entries(info):
	print(info)
	
	
func _on_happytime_pressed():
	WebBus.happytime()


func _on_start_gameplay_pressed():
	WebBus.start_gameplay()


func _on_stop_gameplay_pressed():
	WebBus.stop_gameplay()


func _on_start_loading_pressed():
	WebBus.start_loading()


func _on_init_payments_pressed() -> void:
	WebBus.init_payments($VBoxContainer/Yandex/HBoxContainer5/signed.button_pressed)


func _on_purchase_pressed() -> void:
	print(await WebBus.purchase($VBoxContainer/Yandex/HBoxContainer6/id_String.text, $VBoxContainer/Yandex/HBoxContainer6/developer_payload_String.text))

	
func _on_get_purchases_pressed():
	print(await WebBus.get_purchases())


func _on_get_catalog_pressed():
	print(await WebBus.get_catalog())


func _on_can_rewiew_pressed():
	var feedback_info = await WebBus.can_rewiew()
	print(feedback_info) # bool


func _on_request_review_pressed():
	var feedback_request = await WebBus.request_review()
	print(feedback_request) # bool


func _on_get_platform_pressed():
	var platform = WebBus.get_platform()
	print(platform) # string


func _on_invite_link_pressed():
	var params := {}
	params[$VBoxContainer/HBoxContainer/Invite/HBoxContainer/key.text] = $VBoxContainer/HBoxContainer/Invite/HBoxContainer/value.text
	var result = await WebBus.invite_link(params)
	print(result)
	

func _on_get_invite_param_pressed():
	print(await WebBus.get_invite_param($VBoxContainer/HBoxContainer/Invite/HBoxContainer2/key.text))


func _on_show_invite_button_pressed():
	var params := {}
	params[$VBoxContainer/HBoxContainer/Invite/HBoxContainer/key.text] = $VBoxContainer/HBoxContainer/Invite/HBoxContainer/value.text
	WebBus.show_invite_button(params)


func _on_hide_invite_button_pressed():
	WebBus.hide_invite_button()
	

func _on_consume_purchase_pressed() -> void:
	print(await WebBus.consume_purchase($VBoxContainer/Yandex/HBoxContainer9/token.text))


func _on_set_data_pressed() -> void:
	WebBus.set_data({$VBoxContainer/HBoxContainer/Data/HBoxContainer/key.text: $VBoxContainer/HBoxContainer/Data/HBoxContainer/value.text})


func _on_get_data_pressed() -> void:
	print(await WebBus.get_data([$VBoxContainer/HBoxContainer/Data/HBoxContainer2/key.text]))


func _on_open_auth_dialog_pressed() -> void:
	WebBus.open_auth_dialog()


func _on_set_stats_pressed() -> void:
	WebBus.set_stats({$VBoxContainer/HBoxContainer/Data/HBoxContainer4/key.text: float($VBoxContainer/HBoxContainer/Data/HBoxContainer4/value.text)})


func _on_get_stats_pressed() -> void:
	print(await WebBus.get_stats([$VBoxContainer/HBoxContainer/Data/HBoxContainer5/key.text]))
