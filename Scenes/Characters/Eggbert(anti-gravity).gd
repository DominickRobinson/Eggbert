extends Character

export var FLIGHT_ANGLE_DEGREES := 35
var FLIGHT_ANGLE

var flap = false

onready var trail

const trailResource = preload("res://Scenes/Particles/EggbertSpaceTrail.tscn")
const explosionResource = preload("res://Scenes/Particles/ExplosionCPU.tscn")


func _ready():
	FLIGHT_ANGLE = deg2rad(FLIGHT_ANGLE_DEGREES)
	GameManager.mode = GameManager.GameModes.ANTI_GRAVITY
	anim.play("glide")
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
		motion = move_and_slide(motion, UP)

func flap():
	if not alive or not started:
		return
	FLIGHT_ANGLE *= -1
	motion = Vector2(cos(FLIGHT_ANGLE), sin(FLIGHT_ANGLE)) * HORIZONTAL_SPEED
	rotation = FLIGHT_ANGLE + PI/2
	GameManager.play_audio("res://Assets/SoundEffects/zoom.mp3", 10)
	create_explosion(.25, -40)

func start_moving():
	motion = Vector2(cos(FLIGHT_ANGLE), sin(FLIGHT_ANGLE)) * HORIZONTAL_SPEED

func add_trail():
	trail = trailResource.instance()
	add_child(trail)
	trail.despawn = false

func die(time=4.5):
	$Sizzling.stop()
	trail.queue_free()
	speak("Uh oh . . .", 2, "yell")
	.die(time)

	GameManager.play_audio("res://Assets/SoundEffects/meemo_meemo.mp3", 10)

	yield(get_tree().create_timer(2.5), "timeout")
	explode()


func _on_animation_finished(anim_name):
	._on_animation_finished(anim_name)
	match anim_name:
		"flap":
			anim.play("idle")

func _on_point():
	HORIZONTAL_SPEED *= 1.02

func _on_Button_pressed():
	flap()
	FLIGHT_ANGLE *= 1.01


func explode():
	create_explosion()
	create_explosion(.7)
	create_explosion(.3)
	visible = false

func create_explosion(s : float = 1.0, vol : float = 20.0):
	var explosion = explosionResource.instance()
	explosion.scale *= s
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	explosion.pow_sound(vol)
