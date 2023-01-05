extends CanvasLayer

onready var pause_menu = $PauseMenu
onready var pause_button = $Buttons/Bar/Pause

onready var score = $Score/HBoxContainer/Value


func _ready():
	pass


func set_score(value):
	print(value)
	score.text = str(value)


func _on_Restart_pressed():
	GameManager.reload()

func _on_Quit_pressed():
	GameManager.quit()
