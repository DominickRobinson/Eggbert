extends CPUParticles2D


func _ready():
	GameManager.play_audio("res://Assets/SoundEffects/pow.mp3", -15)
	emitting = true
