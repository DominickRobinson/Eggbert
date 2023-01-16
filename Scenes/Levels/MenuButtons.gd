extends VBoxContainer

var button_script = load("res://Scripts/ButtonSound.gd")

func _ready():
	for c in get_children():
		if not c is Button:
			continue
		c.set_script(button_script)
		c.connect_sounds()
