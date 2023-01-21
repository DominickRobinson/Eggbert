extends Node2D

var frequency := 16

export (String, FILE, "*.tscn") var resourcePath := "res://Scenes/Particles/Space/Asteroid.tscn"

export var avg_speed := 300
export var front := true
export var direction_degrees := 0


var resource


var rng = RandomNumberGenerator.new()


func _ready():
	yield(self, "ready")
	resource = load(resourcePath)
	$Timer.connect("timeout", self, "generate")
	GameManager.get_player().connect("point", self, "on_point")
	start_timer()

func generate():
	var a = resource.instance()
	rng.randomize()
	a.speed = rng.randi_range(avg_speed, 2 * avg_speed)
	rng.randomize()
	a.direction_degrees = -direction_degrees + rng.randi_range(-25,25)
	a.angular_velocity *= rng.randf_range(-5,5)
	
	rng.randomize()
	a.position = position + Vector2(rng.randi_range(-300, 300), 0).rotated(deg2rad(-direction_degrees))
	rng.randomize()
	var val = rng.randf_range(2, 3.5)
	a.scale *= val
	
	add_child(a)
	
	if front:
		pass
	else:
		a.modulate = Color(.4,.4,.4)
		a.scale *= .3
		a.speed *= .3
	
	start_timer()


func start_timer():
	rng.randomize()
	frequency = rng.randi_range(2, 20)
	$Timer.wait_time = frequency
	$Timer.start()


func on_point():
#	print("increase asteroid speed")
	pass
