extends Node2D

export var speed := 500
export var direction_degrees := 90
export var angular_velocity := 50

export var despawn := true

export var parallax_factor := 1

onready var sprite = $Sprite
onready var trail = $AsteroidTrail
onready var trailLine = $AsteroidTrail/Smoketrail


var spawner = get_parent()


func _ready():
	yield(self, "ready")
	yield(get_tree().create_timer(.1), "timeout")
	yield(get_tree().create_timer(30), "timeout")
	if despawn:
		print("Despawn")
		queue_free()

func _physics_process(delta):
	var direction = deg2rad(direction_degrees)
	global_position += Vector2(cos(direction), sin(direction)) * speed * delta
	if is_instance_valid($Sprite):
		$Sprite.rotation_degrees += angular_velocity * delta
	
#	global_position = get_global_mouse_position()
