extends Node2D

export var frequency := 16
export var start_delay := 1

export (String, FILE, "*.tscn") var resourcePath := "res://Scenes/Particles/Space/Asteroid.tscn"

export var avg_speed := 300
export var front := true
export var direction_degrees := 0


var resource


var rng = RandomNumberGenerator.new()


func _ready():
	resource = load(resourcePath)
	$Timer.wait_time = start_delay
	$Timer.connect("timeout", self, "generate")
	$Timer.start()

func generate():
	print("generate")
	var a = resource.instance()
	rng.randomize()
	a.speed = rng.randi_range(avg_speed, 2 * avg_speed)
	rng.randomize()
	a.direction_degrees = rng.randi_range(-35,35) + direction_degrees
	a.angular_velocity *= rng.randf_range(-3,3)
	
	rng.randomize()
	a.position = Vector2(0, rng.randi_range(-300, 300)).rotated(deg2rad(direction_degrees)) + position
	rng.randomize()
	var val = rng.randf_range(2, 3.5)
	a.scale *= val
	
	add_child(a)
	
	
	print("Direction degrees: " + str(direction_degrees) + "  -  " + str(a.position))
	
	
	if front:
		pass
	else:
		a.modulate = Color(.2,.2,.2)
		a.scale *= .3
		a.speed *= .3
	
#	$Timer.start(frequency * rng.randf_range(.5, 1.5))
