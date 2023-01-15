extends Control


onready var submit_button = $PausePanel/CenterContainer/VBoxContainer/SubmitScore




func _on_SubmitScore_pressed():
	if GameManager.player_name != "":
		GameManager.upload_score()
		submit_button.disabled = true
	else:
		$PausePanel/CenterContainer/VBoxContainer/EnterName.play("enter_name")
