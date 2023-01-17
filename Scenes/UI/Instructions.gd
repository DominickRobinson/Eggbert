extends Control

func _ready():
	show()
#	get_tree().paused = true
	$AnimationPlayer.play("blink")

func _unhandled_input(event):
	if Input.is_action_just_pressed("start"):
		start()

func _on_Start_pressed():
	start()


func start():
#	get_tree().paused = false
	get_parent().start()
	queue_free()
