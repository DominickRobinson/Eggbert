extends Character

export var FLAP := 150

var flap = false


func _ready():
	GameManager.mode = GameManager.GameModes.FLAP
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


func flap():
	if not alive:
		return
	motion.y = -FLAP
	anim.stop()
	anim.play("flap")
	mee_moo()





func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"flap":
			anim.play("idle")


func _on_point():
	motion.x *= 1.00
	GRAVITY *= 1.00
	FLAP *= 1.00
	MAX_FALL_SPEED *= 1.00
