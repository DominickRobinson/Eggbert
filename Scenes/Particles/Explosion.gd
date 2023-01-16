extends CPUParticles2D

const pow_filepath = "res://Assets/SoundEffects/pow.mp3"

func _ready():
	GameManager.play_audio(pow_filepath, 20)
	emitting=true
	for c in get_children():
		c.emitting=true
	
	yield(get_tree().create_timer(5), "timeout")
	queue_free()
