extends ParallaxLayer

export var CLOUD_SPEED := -10

func _physics_process(delta):
	motion_offset.x += CLOUD_SPEED * delta
