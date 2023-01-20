extends Node


onready var fg = $Foreground
onready var bg = $Background

func _ready():
	fg.offset.x = GameManager.get_screen_size().x/2
	bg.offset.x = GameManager.get_screen_size().x/2
