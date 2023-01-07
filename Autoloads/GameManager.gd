extends Node


onready var GUI

signal point

var display_resolution = Vector2(ProjectSettings.get_setting("display/window/size/width"), 
									ProjectSettings.get_setting("display/window/size/width"))

var score = 0

func _ready():
	GUI = get_tree().get_current_scene().get_node("GUI")

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func increment_score():
	GUI = get_tree().get_current_scene().get_node("GUI")
	score += 1
	if is_instance_valid(GUI):
		GUI.set_score(score)
	emit_signal("point")


func lose():
	if is_instance_valid(GUI):
		GUI.lose(score)

func reload():
	score = 0
	get_tree().paused = false
	get_tree().reload_current_scene()

func main_menu():
	get_tree().change_scene("res://Scenes/Levels/MainMenu.tscn")

func quit():
	get_tree().quit()

func get_screen_size():
	return display_resolution
