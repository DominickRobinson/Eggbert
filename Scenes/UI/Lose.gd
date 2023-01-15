extends Control


onready var submit_button = $PausePanel/CenterContainer/VBoxContainer/SubmitScore

onready var Name = $PausePanel/CenterContainer/VBoxContainer/HBoxContainer/Name


func _on_SubmitScore_pressed():
	if Name.text != "":
		GameManager.player_name = Name.text
		GameManager.upload_score()
		submit_button.disabled = true
	else:
		$PausePanel/CenterContainer/VBoxContainer/EnterName.play("enter_name")
