extends Control

export (String, FILE, "*.mp3") var music_filepath := ""
export (float) var music_volume_db := -9.0

onready var lb = $CanvasLayer/Leaderboard
onready var cr =  $CanvasLayer/Credits

func _ready():
	lb.refresh_leaderboards()
	MusicManager.play_track("title")

func _on_Flappy_pressed():
	get_tree().change_scene("res://Scenes/Levels/Flappy.tscn")

func _on_Glide_pressed():
	get_tree().change_scene("res://Scenes/Levels/Glide.tscn")

func _on_Float_pressed():
	get_tree().change_scene("res://Scenes/Levels/Swim.tscn")

func _on_Antigravity_pressed():
	get_tree().change_scene("res://Scenes/Levels/Anti-Gravity.tscn")

func _on_Leaderboards_pressed():
	lb.show()

func _on_Credits_pressed():
	cr.show()


func _on_Quit_pressed():
	get_tree().quit()










