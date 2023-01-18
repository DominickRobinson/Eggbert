extends Node2D

export var frequency := 5
export (String, FILE, "*.tscn") var resourcePath := "res://Scenes/Particles/Space/Asteroid.tscn"

export var avg_speed := 500

var resource


var rng = RandomNumberGenerator.new()


func _ready():
	resource = load(resourcePath)
	$Timer.wait_time = frequency
	$Timer.connect("timeout", self, "generate")
	$Timer.start()

func generate():
	var a = resource.instance()
	rng.randomize()
	a.speed = rng.randi_range(.7 * avg_speed, 1.3 * avg_speed)
	rng.randomize()
	a.direction_degrees = rng.randi_range(55, 125)
	
	get_parent().add_child(a)
	a.global_position = global_position
	rng.randomize()
	a.global_position.x += rng.randi_range(-300, 300)
	
	$Timer.start(frequency)
