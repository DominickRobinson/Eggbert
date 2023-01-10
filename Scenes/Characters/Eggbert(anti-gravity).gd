extends Character

export var FLIGHT_ANGLE_DEGREES := 35
var FLIGHT_ANGLE = deg2rad(FLIGHT_ANGLE_DEGREES)

var flap = false


func _ready():
	GameManager.mode = GameManager.GameModes.ANTI_GRAVITY
	flap()
	anim.play("glide")
	$Touch/Button.connect("pressed", self, "flap")

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("flap"):
		flap()

func _physics_process(delta):
	if alive:
		motion = move_and_slide(motion, UP)


func flap():
	if not alive:
		return
	FLIGHT_ANGLE *= -1
	motion = Vector2(cos(FLIGHT_ANGLE), sin(FLIGHT_ANGLE)) * HORIZONTAL_SPEED
	rotation = FLIGHT_ANGLE

func die():
	.die()
	
	yield(get_tree().create_timer(2.0), "timeout")
	explode()


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"flap":
			anim.play("idle")

func _on_point():
	HORIZONTAL_SPEED *= 1.02

func _on_Button_pressed():
	flap()


func explode():
	queue_free()
