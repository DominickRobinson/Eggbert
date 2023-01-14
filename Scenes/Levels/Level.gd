extends Node2D

export (String, FILE, "*.mp3") var music_filepath := ""
export (float) var music_volume_db := -10.0


func _ready():
	GameManager.play_audio(music_filepath, music_volume_db)
