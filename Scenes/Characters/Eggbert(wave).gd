extends Character



func _ready():
	motion.x = HORIZONTAL_SPEED
#	GameManager.connect("point", self, "_on_point")
	anim.play("wave")
	speak("hi there!", 10, "normal")
