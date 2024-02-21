extends Control

func _ready():
	WebSDK.ad_closed.connect(ad_closed)
	WebSDK.ad_error.connect(ad_error)
	WebSDK.ad_started.connect(ad_started)
	WebSDK.reward_added.connect(reward_added)
	WebSDK.type_device_recieved.connect(type_device_recieved)


func _on_show_ad_pressed():
	WebSDK.show_ad()


func _on_show_reward_ad_pressed():
	WebSDK.show_reward_ad()


func _on_get_yandex_language_pressed():
	WebSDK.get_yandex_language()


func _on_get_type_device_pressed():
	WebSDK.get_type_device()


func _on_set_yandex_leaderboard_pressed():
	var name_leaderboard :String = $VBoxContainer/HBoxContainer/leaderboard.text
	var score: int = int($VBoxContainer/HBoxContainer/score.text)
	WebSDK.set_yandex_leaderboard(name_leaderboard, score)
	

func ad_closed():
	print("ad_closed")
	
func ad_error():
	print("ad_error")
	
func ad_started():
	print("ad_started")
	
func reward_added():
	print("reward_added")
	
func type_device_recieved(type):
	print("device_type: ", type)
