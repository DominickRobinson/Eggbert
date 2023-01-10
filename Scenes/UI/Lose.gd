extends Control


onready var submit_button = $PausePanel/CenterContainer/VBoxContainer/SubmitScore




func _on_SubmitScore_pressed():
	GameManager.upload_score()
	submit_button.disabled = true
