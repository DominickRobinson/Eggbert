extends Node


onready var GUI

signal point

enum GameModes {FLAP, GLIDE, SWIM, ANTI_GRAVITY}
var mode = GameModes.FLAP
var ModeDictionary = {
	GameModes.FLAP : "flappy",
	GameModes.GLIDE : "glide",
	GameModes.SWIM : "swim",
	GameModes.ANTI_GRAVITY : "anti_gravity",
}

var display_resolution = Vector2(ProjectSettings.get_setting("display/window/size/width"), 
									ProjectSettings.get_setting("display/window/size/width"))

var player_name = ""
var score = 0

func _ready():
	GUI = get_GUI()

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func increment_score():
	GUI = get_GUI()
	score += 1
	if is_instance_valid(GUI):
		GUI.set_score(score)
	emit_signal("point")


func lose():
	GUI = get_GUI()
	if is_instance_valid(GUI):
		GUI.lose(score)

func reload():
	score = 0
	get_tree().paused = false
	get_tree().reload_current_scene()

func play_audio(filepath = "", vol = 0):
	var a = AudioStreamPlayer.new()
	a.stream = load(filepath)
	a.volume_db = vol
	get_tree().get_current_scene().add_child(a)
	a.play()
	return a
#	yield(a, "finished")
#	a.queue_free()


func main_menu():
	get_tree().change_scene("res://Scenes/Levels/MainMenu.tscn")

func quit():
	get_tree().quit()

func get_screen_size():
	return display_resolution

func get_GUI():
	return get_tree().get_current_scene().get_node("GUI")

func upload_score():
	SilentWolf.Scores.persist_score(GameManager.player_name, GameManager.score, ModeDictionary[mode])
