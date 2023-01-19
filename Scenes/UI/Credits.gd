extends Control


func _ready():
	hide()

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("pause"):
		hide()

func _on_Close_pressed():
	hide()
