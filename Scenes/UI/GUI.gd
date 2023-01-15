extends CanvasLayer

export (String) var mode := "*MODE"
export (String, MULTILINE) var instructions := "*insert instructions here"

onready var pause_menu = $PauseMenu
onready var pause_button = $Buttons/Bar/Pause
onready var restart_button = $Buttons/Bar/Restart

onready var score = $Score/HBoxContainer/VBoxContainer/Value

onready var leaderboard = $Lose/Leaderboard


func _ready():
	prep()
	pause_button.connect("pressed", pause_menu, "_on_Pause_pressed")
	restart_button.connect("pressed", self, "_on_Restart_pressed")


func prep():
	$Instructions.visible = true
	$PauseMenu.visible = false
	$Lose.visible = false
	$Score.visible = false
	$Buttons.visible = false
	leaderboard.visible = false
	$Instructions/Background/CenterContainer/VBoxContainer/Mode.text = mode
	$Instructions/Background/CenterContainer/VBoxContainer/Instructions.text = instructions

func start():
#	$Instructions.visible = false
	$PauseMenu.visible = false
	$Lose.visible = false
	$Score.visible = true
	$Buttons.visible = true
	leaderboard.visible = false


func set_score(value):
	print(value)
	score.bbcode_text = "[rainbow]" + str(value)

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



func _on_MainMenu_pressed():
	pass # Replace with function body.
