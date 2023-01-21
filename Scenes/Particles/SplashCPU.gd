extends CPUParticles2D

export var vol := -15

func _ready():
	GameManager.play_audio("res://Assets/SoundEffects/pow.mp3", vol)
	emitting = true
