extends Character

export var FLAP := 150

var flap = false


func _ready():
	motion.x = HORIZONTAL_SPEED
	$Touch/Button.connect("pressed", self, "flap")

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("flap"):
		flap()

func _physics_process(delta):
	if alive:
		motion.y += GRAVITY
		if motion.y > MAX_FALL_SPEED:
			motion.y = MAX_FALL_SPEED
		motion = move_and_slide(motion, UP)
	else:
		motion.y += DEATH_GRAVITY
		motion = move_and_slide(motion, UP)


func flap():
	if not alive:
		return
	motion.y = -FLAP
	anim.stop()
	anim.play("flap")

func die():
	alive = false
	anim.stop()
	anim.play("death")
	motion.y = -600
	motion.x = 0
	lose_popup()




func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"flap":
			anim.play("idle")


func _on_point():
	motion.x *= 1.02
	GRAVITY *= 1.02 * 1.02
	FLAP *= 1.02
	MAX_FALL_SPEED *= 1.02
