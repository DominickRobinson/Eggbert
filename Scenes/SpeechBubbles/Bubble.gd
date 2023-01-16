extends Node2D

onready var speech = $Speech
onready var timer = $Timer

var tween = Tween.new()

func _ready():
	scale = Vector2(0, 0)

func _physics_process(delta):
	global_rotation = 0
	scale = lerp(scale, Vector2(1,1), .07)


func prepare(text, time):
	set_text(text)
	set_timer(time)

func set_text(text):
	speech.text = text

func set_timer(time):
	timer.start(time)
	yield(timer, "timeout")
	queue_free()
