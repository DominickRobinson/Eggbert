extends Button

var hover_audio = "res://Assets/SoundEffects/mee.mp3"
var click_audio = "res://Assets/SoundEffects/mo.mp3"


func connect_sounds():
	self.connect("mouse_entered", self, "hover_sound")
	self.connect("pressed", self, "click_sound")


func hover_sound():
	GameManager.play_audio(hover_audio, -15)

func click_sound():
	GameManager.play_audio(click_audio)
