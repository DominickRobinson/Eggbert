extends Character

export var FLIGHT_ANGLE_DEGREES := 35
var FLIGHT_ANGLE = deg2rad(FLIGHT_ANGLE_DEGREES)

var flap = false


func _ready():
	flap()
	anim.play("glide")
	$Touch/Button.connect("pressed", self, "flap")

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("flap"):
		flap()

func _physics_process(delta):
	if alive:
		motion = move_and_slide(motion, UP)
	else:
		motion.x = lerp(motion.x, 0, .02)
		motion.y += DEATH_GRAVITY
		motion = move_and_slide(motion, UP)


func flap():
	if not alive:
		return
	FLIGHT_ANGLE *= -1
	motion = Vector2(cos(FLIGHT_ANGLE), sin(FLIGHT_ANGLE)) * HORIZONTAL_SPEED
	rotation = FLIGHT_ANGLE

func die():
	alive = false
	anim.stop()
	anim.play("death")
	motion.y = -300
	motion.x = -HORIZONTAL_SPEED * 2
	lose_popup()
	$Detect.collision_layer = 0
	$Detect.collision_mask = 0



func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"flap":
			anim.play("idle")

func _on_point():
	HORIZONTAL_SPEED *= 1.02

func _on_Button_pressed():
	flap()
