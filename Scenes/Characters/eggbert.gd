extends KinematicBody2D


export var FLAP := 200
export var MAX_FALL_SPEED := 200


const UP = Vector2(0,-1)
const GRAVITY = 10

var motion = Vector2()

var alive = true

enum abilities {flappy, na}
var current_ability = abilities.flappy


func _ready():
	pass



func _unhandled_key_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _physics_process(delta):
#	do nothing if dead
	if not alive:
		return false
		
#	match unique movement styles to mode
	match current_ability:
		
		abilities.flappy:
			motion.y += GRAVITY
			if motion.y > MAX_FALL_SPEED:
				motion.y = MAX_FALL_SPEED
			
			if Input.is_action_just_pressed("flap"):
				motion.y = -FLAP
				flap()
			
			motion = move_and_slide(motion, UP)
			
		abilities.na:
			pass


func flap():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("flap")


func die():
	alive = false
	$AnimationPlayer.play("death")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "flap":
		$AnimationPlayer.play("fall")
