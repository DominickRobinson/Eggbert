extends Character

export var FLAP := 150

var flap = false


func _ready():
	motion.x = HORIZONTAL_SPEED
	GameManager.connect("point", self, "_on_point")

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
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


func _on_Detect_body_entered(body):
	if not alive:
		return
	die()


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"flap":
			anim.play("idle")


func _on_JumpPad_gui_input(event):
	if event is InputEventScreenTouch or Input.is_action_just_pressed("left_mouseclick"):
		flap()

func _on_point():
	motion.x *= 1.02
	GRAVITY *= 1.02 * 1.02
	FLAP *= 1.02
