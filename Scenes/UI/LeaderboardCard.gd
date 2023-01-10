extends ColorRect

export var player_name := "*insert name"
export var score := "-69"

export var header := false

onready var name_label = $HBoxContainer/Name
onready var score_label = $HBoxContainer/Score




func _ready():
	set_card()
	if header:
		remove_from_group("Cards")

func set_card(n = player_name, s = score):
	set_name(n)
	set_score(s)

func set_name(n = player_name):
	player_name = pad_spaces(n)
	$HBoxContainer/Name.text = player_name

func set_score(s = score):
	score = s
	$HBoxContainer/Score.text = s


func pad_spaces(s : String):
	var space = "                                      "
	var p = s + space
	p = p.left(16)
	return p
