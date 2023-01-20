extends Character

export var FLAP := 150

const windResource = preload("res://Scenes/Particles/WindCPU.tscn")
const splashResourceBig = preload("res://Scenes/Particles/SplashCPU2.tscn")
const splashResourceSmall = preload("res://Scenes/Particles/SplashCPU3.tscn")

var flap = false


func _ready():
	GameManager.mode = GameManager.GameModes.FLAP
	motion = Vector2(1,0).rotated(-deg2rad(70)) * HORIZONTAL_SPEED
	motion.x = HORIZONTAL_SPEED
	$Touch/Button.connect("pressed", self, "flap")

func _unhandled_key_input(event):
	if not started:
		return
	if Input.is_action_just_pressed("flap"):
		flap()

func _physics_process(delta):
	if not started:
		return
	
	if alive:
		motion.y += GRAVITY
		if motion.y > MAX_FALL_SPEED:
			motion.y = MAX_FALL_SPEED
		motion = move_and_slide(motion, UP)

func flap():
	if not alive or not started:
		return
	motion.y = -FLAP
	anim.stop()
	anim.play("flap")
	mee_moo()


func die(time=1.5):
	.die(time)
	speak("OOWWWW!!", 3, "yell")
	GameManager.play_audio("res://Assets/SoundEffects/ow.mp3", 10)




func _on_animation_finished(anim_name):
	._on_animation_finished(anim_name)
	match anim_name:
		"flap":
			anim.play("flap_idle")


func _on_point():
	motion.x *= 1.00
	GRAVITY *= 1.00
	FLAP *= 1.00
	MAX_FALL_SPEED *= 1.00


func splash(big : bool):
	var s
	if big:
		s = splashResourceBig.instance()
	else:
		s = splashResourceSmall.instance()
	get_parent().add_child(s)
	s.global_position = global_position + Vector2(0, 32)
