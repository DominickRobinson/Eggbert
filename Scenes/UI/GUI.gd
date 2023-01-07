extends CanvasLayer

onready var pause_menu = $PauseMenu
onready var pause_button = $Buttons/Bar/Pause

onready var score = $Score/HBoxContainer/VBoxContainer/Value


func _ready():
	prep()


func prep():
	$PauseMenu.visible = false
	$Lose.visible = false
	$Score.visible = false
	$Buttons.visible = false

func start():
	$PauseMenu.visible = false
	$Lose.visible = false
	$Score.visible = true
	$Buttons.visible = true


func set_score(value):
	print(value)
	score.bbcode_text = "[center][rainbow]" + str(value)

func lose(value):
	$Buttons.visible = false
	$Score.visible = false
	$Lose.visible = true
	$Lose/PausePanel/CenterContainer/VBoxContainer/Score.bbcode_text = "[center]Score: [rainbow][wave]" + str(value)

func _on_Restart_pressed():
	GameManager.reload()

func _on_Quit_pressed():
	GameManager.quit()


func _on_Start_pressed():
	pass # Replace with function body.
