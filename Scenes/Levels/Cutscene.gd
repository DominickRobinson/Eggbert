extends AnimationPlayer

func _ready():
	play("RESET")
	play("glide_start")
	
	yield(self, "animation_finished")
	get_parent().started = true
