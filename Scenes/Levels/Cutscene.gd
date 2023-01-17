extends AnimationPlayer

#export (String, "flappy", "glide", "swim", "anti-gravity", "none") var cutscene := "none"
#var cutscene

func reset_cutscene(cutscene):
	play("RESET_" + cutscene)


func play_cutscene(cutscene):
	match cutscene:
		"none":
			get_parent().started = true
		_:
			reset_cutscene(cutscene)
			play("cutscene_" + cutscene)
			yield(self, "animation_finished")
			get_parent().started = true
