extends Particles2D

export var activation_dist := 4000

func _physics_process(delta):
	if global_position.x > activation_dist:
		emitting = true
