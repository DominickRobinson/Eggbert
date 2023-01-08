extends Node

var player_name = ""


func _ready():
	var api_key = "U4mUI3bD1G95AMhxbvvaL5jFMFRjCSkt2obMIQ3T"
	var game_id = "theadventuresofeggberttheeagle"
	
	var config = {
		"api_key": api_key,
		"game_id": game_id,
		"game_version": "1.0.0",
		"log_level": 1
	}

	var scores_config = {
		"open_scene_on_close": "res://Scenes/Levels/MainMenu.tscn"
	}
	
	SilentWolf.configure(config)
	SilentWolf.configure_scores(scores_config)



func set_player_name(name):
	player_name = name
