extends Character

export var GLIDE := .06
export var ANGULAR_GRAVITY := .03

var glide_rotation = 0

#onready var audio = $AudioStreamPlayer

var audio
const MAX_ROTATION = PI/2.5


func _ready():
	GameManager.mode = GameManager.GameModes.GLIDE
	motion.x = HORIZONTAL_SPEED
	anim.play("glide")

func _physics_process(delta):
	glide_rotation = clamp(glide_rotation, -MAX_ROTATION, MAX_ROTATION)
	if Input.is_action_pressed("glide") or $Touch/Button.pressed:
		glide()
	if Input.is_action_just_pressed("glide"):
		audio = GameManager.play_audio("res://Assets/SoundEffects/woosh.mp3", 7)
		audio.stop()
		audio.volume_db = 7
		audio.play()
	if Input.is_action_just_released("glide"):
		if is_instance_valid(audio):
			audio.volume_db = lerp(audio.volume_db, -24, .15)
	if alive:
		anim.playback_speed = (1 - glide_rotation/MAX_ROTATION)/2 + 0.5
		glide_rotation += ANGULAR_GRAVITY
		motion = Vector2(1,0).rotated(glide_rotation) * HORIZONTAL_SPEED
		motion = move_and_slide(motion, UP)
		rotation = glide_rotation



func glide():
	if not alive:
		return
	anim = anim as AnimationPlayer
	glide_rotation -= GLIDE

func die(time=2.5):
	.die(time)
	anim.playback_speed = 1.0
#	$Body/Wind.one_shot = true
	$Body/Wind.queue_free()
	speak("NOOOO!!", 3, "yell")
	GameManager.play_audio("res://Assets/SoundEffects/mo_mo.mp3", 15)


func _on_point():
	HORIZONTAL_SPEED *= 1.02
	ANGULAR_GRAVITY *= 1.02
	GLIDE *= 1.02




