extends Control

var is_paused = false setget set_is_paused


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused


func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused



func _on_Pause_pressed():
	self.is_paused = true


func _on_Resume_pressed():
	self.is_paused = false

func _on_Restart_pressed():
	self.is_paused = false
	GameManager.reload()

func _on_MainMenu_pressed():
	self.is_paused = false
	GameManager.main_menu()

func _on_Quit_pressed():
	GameManager.quit()

func _on_UnpauseBG_pressed():
	self.is_paused = false
