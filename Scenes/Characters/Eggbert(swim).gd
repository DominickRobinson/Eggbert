extends Character

export var SWIM_SPEED := 4

var float_playback_speed
var click_position = global_position

var swim = false

var maskResource = preload("res://Scenes/Props/Mask.tscn")
onready var mask

func _ready():
	anim.play("swim")
	motion.x = HORIZONTAL_SPEED
	
	mask = maskResource.instance()
	$Body/Head.add_child(mask)


func _physics_process(delta):
	swim = $Touch/Button.pressed
	if alive:
		swim()
		motion.x = HORIZONTAL_SPEED
		motion = move_and_slide(motion, UP)
	else:
		motion.y += DEATH_GRAVITY
		motion = move_and_slide(motion, UP)

func swim():
	if swim:
		click_position = get_global_mouse_position()
		motion.y = (click_position.y - global_position.y) * SWIM_SPEED
		rotation = motion.angle() + PI/2
		yield(self,"ready")
		anim.playback_speed = float_playback_speed*2
	else:
		motion.y = 0
		yield(self,"ready")
		anim.playback_speed = float_playback_speed

func die():
	alive = false
	anim.stop()
	anim.play("death")
	anim.playback_speed = .5
	DEATH_GRAVITY = -1
	motion.x = 0
	motion.y *= -.3
	
	mask.queue_free()
	
	yield(get_tree(), "physics_frame")
	mask = maskResource.instance()
	get_tree().get_current_scene().add_child(mask)
	mask.floating = true
	mask.scale.x *= $Body.scale.x * 1.2
	mask.scale.y *= $Body.scale.y * 1.2
	mask.global_position = $Body/Head.global_position
	
	lose_popup()



func _on_point():
	HORIZONTAL_SPEED *= 1.02
	SWIM_SPEED *= 1.02

func _on_AnimationPlayer_animation_changed(old_name, new_name):
	if new_name == "swim":
		anim.playback_speed = float_playback_speed
	else:
		anim.playback_speed = 1
