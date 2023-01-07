extends Sprite

var floating = false

var GRAVITY = -2
var motion = Vector2(-100, 150)

onready var anim = $AnimationPlayer

func _physics_process(delta):
	if floating:
		anim.play("float")
		anim.playback_speed = .1
		motion.y += GRAVITY
		position += motion * delta
