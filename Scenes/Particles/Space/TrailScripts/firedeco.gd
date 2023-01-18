extends Node2D

onready var smoketrail = $Smoketrail
onready var fire = $Fire

var time := 0.0

export var speed := 500
export var direction_degrees := 90

export var despawn := true


func _ready():
	yield(self, "ready")
	yield(get_tree().create_timer(10), "timeout")
	if despawn:
		queue_free()

func _process(delta):
	if time > 0.03:
		time = 0
		smoketrail.add_point(global_position)
	fire.scale = rand_range(0.2, 0.1) * Vector2.ONE
	time += delta
	
	var direction = deg2rad(direction_degrees)
	global_position += Vector2(cos(direction), sin(direction)) * speed * delta
