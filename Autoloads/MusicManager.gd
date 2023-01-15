extends Node

#var tracks = {
#	"title" : "res://Assets/Music/2017-04-14_-_Happy_Dreams_-_David_Fesliyan.mp3",
#	"flappy" : "res://Assets/Music/2020-10-19_-_Its_A_Good_Day_-_www.FesliyanStudios.com_Steve_Oxen.mp3",
#	"glide" : "res://Assets/Music/2022-07-13_-_Overcome_-_www.FesliyanStudios.com.mp3",
#	"swim" : "res://Assets/Music/2020-09-14_-_Tropical_Keys_-_www.FesliyanStudios.com_David_Renda.mp3",
#	"anti-gravity" : "res://Assets/Music/2020-10-20_-_Flying_High_-_www.FesliyanStudios.com_Steve_Oxen.mp3"
#}

var current_track = ""

onready var music_player = $MusicPlayer



func play_track(track_name = "", vol = -10.0):
	print("Play new song: " + track_name)
	if current_track == track_name:
		print("already playing...")
		return
	print("success!!")
	current_track = track_name
	
	var filepath = get_track_filepath(current_track)
	music_player.stream = load(filepath)
	music_player.volume_db = vol
	music_player.play()
	return music_player


func get_track_filepath(track_name = ""):
	return "res://Assets/Music/" + track_name + ".mp3"
