extends Control


var leaderboards



func _ready():
	leaderboards = $Panel/CenterContainer/VBoxContainer/TabContainer.get_children()
	hide()


func _on_Close_pressed():
	hide()

func _on_ViewLeaderboard_pressed():
	show()


func _on_Name_text_changed(new_text):
	GameManager.player_name = new_text

func refresh_leaderboards():
	for lb in leaderboards:
		lb.refresh_leaderboard()
