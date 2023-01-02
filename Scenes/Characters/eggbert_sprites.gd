extends Node2D

export var blink_chance_separate := .2
export var blink_chance_together := 0.8

onready var main_sprite = $Body
var rng = RandomNumberGenerator.new()



var sprites = []

func _ready():
	for child in get_children():
		if child is AnimatedSprite:
			sprites.append(child)



func _on_Body_frame_changed():
	for c in sprites:
		c = c as AnimatedSprite
		c.frame = main_sprite.frame
	


func _on_Timer_timeout():
	return false
	
	if $Body.frame == 5:
		$LeftEye.visible = true
		$RightEye.visible = true
	
	rng.randomize()
	var right_rng = rng.randf()
	rng.randomize()
	var left_rng = rng.randf()
	rng.randomize()
	var together_rng = rng.randf()
	
	var blink_right = right_rng < blink_chance_separate
	var blink_left = left_rng < blink_chance_separate
	var blink_together = together_rng < blink_chance_separate
	
	if (blink_right or blink_left) and blink_chance_together:
		blink_right = true
		blink_left = true
	
	$LeftEye.visible = blink_left
	$RightEye.visible = blink_left
	
	if blink_right or blink_left:
		yield(get_tree().create_timer(0.1), "timeout")
		$LeftEye.visible = true
		$RightEye.visible = true
