extends LineEdit

func _ready():
	connect("focus_entered", self, "js_text_entry")

func js_text_entry():
	text = JavaScript.eval(
			"prompt('%s', '%s');" % ["Please enter text:", text], true)

	release_focus()
