extends Character



func _ready():
	anim.play("wave")
	speak("hi there!", 8, "normal")

	yield(get_tree().create_timer(30.0), "timeout")
	speak("do something already,  mee mo . . .", 10, "thought")
	
	yield(get_tree().create_timer(60.0), "timeout")
	speak("no? ok, birdbrain . . .", 10, "thought")
	
	yield(get_tree().create_timer(60.0), "timeout")
	GameManager.play_audio("res://Assets/SoundEffects/ow.mp3", 30)
	speak("WAKE UP!!!", 10, "yell")
	
	
