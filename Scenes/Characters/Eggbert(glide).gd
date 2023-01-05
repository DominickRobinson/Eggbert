extends Character

export var GLIDE := .06
export var ANGULAR_GRAVITY := .03


var glide_rotation = 0


func _ready():
	motion.x = HORIZONTAL_SPEED
	GameManager.connect("point", self, "_on_point")
	anim.play("glide")

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	glide_rotation = clamp(glide_rotation, -PI/3.5, PI/3.5)
	if Input.is_action_pressed("glide"):
		glide()
	if alive:
		glide_rotation += ANGULAR_GRAVITY
		motion = Vector2(1,0).rotated(glide_rotation) * HORIZONTAL_SPEED
		motion = move_and_slide(motion, UP) 
		rotation = glide_rotation
	else:
		motion.y += DEATH_GRAVITY
		motion = move_and_slide(motion, UP)


func glide():
	glide_rotation -= GLIDE


func _on_Detect_body_entered(body):
	if not alive:
		return
	die()


#func _on_JumpPad_gui_input(event):
#	if event is InputEventScreenTouch or (event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.pressed):
#		glide()

func _on_point():
	HORIZONTAL_SPEED *= 1.02
	ANGULAR_GRAVITY *= 1.02
	GLIDE *= 1.02



