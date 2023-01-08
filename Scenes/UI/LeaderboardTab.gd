extends Control

#export var title := "*insert title"

export (Color) var bg_color:= Color(0,0,0)
export (String, "flappy", "glide", "swim", "anti_gravity") var leaderboard_name := "flappy"

onready var title_label = $ColorRect/CenterContainer/VBoxContainer/Title
onready var list = $ColorRect/ScrollContainer/List
onready var bg_panel = $ColorRect

const cardResource = preload("res://Scenes/UI/LeaderboardCard.tscn")

var leaderboard

func _ready():
#	title_label.text = title
	bg_panel.color = bg_color
	yield(get_tree().root, "ready")
	refresh_leaderboard()


func add_card(n, s):
	var card = cardResource.instance()
	card.set_card(n, s)
	list.add_child(card)

func refresh_leaderboard():
	yield(SilentWolf.Scores.get_high_scores(0, leaderboard_name), "sw_scores_received")
	print("Current leaderboard: " + leaderboard_name)
	print("Leaderboards: " + str(SilentWolf.Scores.leaderboards))
	if leaderboard_name in SilentWolf.Scores.leaderboards:
		leaderboard = SilentWolf.Scores.leaderboards[leaderboard_name]
		print("  found :)")
	else:
		print("  not found :(")
	clear_leaderboard()
	fill_leaderboard()
	print(leaderboard_name + " leaderboard: successfully refreshed")


func fill_leaderboard():
	if leaderboard == null: 
		return
	for p in leaderboard:
		add_card(p.player_name, str(int(p.score)))
	print(leaderboard_name + " leaderboard: successfully filled")


func clear_leaderboard():
	if leaderboard == null: 
		return
	for c in list.get_children():
		if c.is_in_group("Cards"):
			c.queue_free()
	print(leaderboard_name + " leaderboard: successfully cleared")


func refresh():
	pass # Replace with function body.
