extends Control

func _ready():
	WebBus.ad_closed.connect(ad_closed)
	WebBus.ad_error.connect(ad_error)
	WebBus.ad_started.connect(ad_started)
	WebBus.reward_added.connect(reward_added)
	WebBus.leaderboard_info_recieved.connect(getting_leaderboard_info)
	WebBus.leaderboard_player_entry_recieved.connect(getting_leaderboard_player_entry)

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
	WebBus.set_yandex_leaderboard(name_leaderboard, score)
	
func _on_yandex_ready_pressed():
	WebBus.yandex_ready()

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
	print(info.score)

func _on_happytime_pressed():
	WebBus.crazy_happytime()


func _on_start_gameplay_pressed():
	WebBus.start_gameplay()


func _on_stop_gameplay_pressed():
	WebBus.stop_gameplay()


func _on_start_loading_pressed():
	WebBus.crazy_start_loading()


func _on_stop_loading_pressed():
	WebBus.crazy_stop_loading()
