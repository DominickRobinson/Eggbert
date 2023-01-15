extends Node2D


export (String, "title", "flappy", "glide", "swim", "anti-gravity") var track := "title"


func _ready():
	MusicManager.play_track(track)
