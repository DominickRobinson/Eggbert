extends Character

export var GLIDE := .06
export var ANGULAR_GRAVITY := .03

var glide_rotation = 0


func _ready():
	GameManager.mode = GameManager.GameModes.GLIDE
	motion.x = HORIZONTAL_SPEED
	anim.play("glide")

func _physics_process(delta):
	glide_rotation = clamp(glide_rotation, -PI/2.5, PI/2.5)
	if Input.is_action_pressed("glide") or $Touch/Button.pressed:
		glide()
	if alive:
		glide_rotation += ANGULAR_GRAVITY
		motion = Vector2(1,0).rotated(glide_rotation) * HORIZONTAL_SPEED
		motion = move_and_slide(motion, UP)
		rotation = glide_rotation



func glide():
	glide_rotation -= GLIDE


func _on_point():
	HORIZONTAL_SPEED *= 1.02
	ANGULAR_GRAVITY *= 1.02
	GLIDE *= 1.02




