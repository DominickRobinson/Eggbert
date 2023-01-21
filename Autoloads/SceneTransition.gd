extends CanvasLayer

onready var anim = $AnimationPlayer

var tran = "dissolve"

func reload_scene():
	change_scene(get_tree().current_scene.filename, true)

func change_scene(target : String, reloading = false):
	
	match target:
		"res://Scenes/Levels/MainMenu.tscn":
			print("... to main menu")
			tran = "title"
		"res://Scenes/Levels/Flappy.tscn":
			print("... to flappy")
			tran = "flap"
		"res://Scenes/Levels/Glide.tscn":
			tran = "glide"
		"res://Scenes/Levels/Swim.tscn":
			tran = "wave"
		"res://Scenes/Levels/Anti-Gravity.tscn":
			tran = "space"
			$SpaceRect/EggbertSprite/AnimationPlayer.play("death")
	
	if reloading:
		anim.playback_speed = 3
		tran = "dissolve"
	else:
		anim.playback_speed = .5
	
	anim.play(tran)
	yield(anim, "animation_finished")
	if not reloading:
		yield(get_tree().create_timer(.1), "timeout")

	get_tree().change_scene(target)
	anim.play_backwards(tran)
	
	yield(anim, "animation_finished")
	anim.play("RESET")
