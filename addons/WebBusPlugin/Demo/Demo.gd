extends Control

func _ready():
	WebBus.ad_closed.connect(ad_closed)
	WebBus.ad_error.connect(ad_error)
	WebBus.ad_started.connect(ad_started)
	WebBus.reward_added.connect(reward_added)
	WebBus.leaderboard_info_recieved.connect(getting_leaderboard_info)
	WebBus.leaderboard_player_entry_recieved.connect(getting_leaderboard_player_entry)
	WebBus.leaderboard_entries_recieved.connect(getting_leaderboard_entries)

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
	print("ad_closed")
	
func ad_error():
	print("ad_error")
	
func ad_started():
	print("ad_started")
	
func reward_added():
	print("reward_added")


var leaderboard_info

func _on_get_yandex_leaderboard_info_pressed():
	var name_leaderboard :String = $VBoxContainer/Yandex/HBoxContainer/leaderboard.text
	WebBus.get_leaderboard_info(name_leaderboard)
	
	
func getting_leaderboard_info(info):
	leaderboard_info = info 
	print(leaderboard_info.name)

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
