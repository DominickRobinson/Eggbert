extends Control



func _on_Flappy_pressed():
	get_tree().change_scene("res://Scenes/Levels/Flappy.tscn")

func _on_Glide_pressed():
	get_tree().change_scene("res://Scenes/Levels/Glide.tscn")

func _on_Float_pressed():
	get_tree().change_scene("res://Scenes/Levels/Swim.tscn")

func _on_Antigravity_pressed():
	get_tree().change_scene("res://Scenes/Levels/Anti-Gravity.tscn")

func _on_Leaderboards_pressed():
	$CanvasLayer/Leaderboard.show()

func _on_Quit_pressed():
	get_tree().quit()







