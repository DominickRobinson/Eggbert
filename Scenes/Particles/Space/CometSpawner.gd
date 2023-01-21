extends Node2D

export var frequency := 20

export (String, FILE, "*.tscn") var resourcePath := "res://Scenes/Particles/Space/Comet.tscn"

export var avg_speed := 300
export var front := false
export var direction_degrees := 120

export var parallax_factor_x := 1.0

var resource


var rng = RandomNumberGenerator.new()


func _ready():
	yield(self, "ready")
	resource = load(resourcePath)
	$Timer.connect("timeout", self, "generate")
	GameManager.get_player().connect("point", self, "on_point")
	$Timer.start(frequency)

func generate():
	var a = resource.instance()
	rng.randomize()
	a.speed = rng.randi_range(.5 * avg_speed, 2 * avg_speed)
	rng.randomize()
	a.direction_degrees = -direction_degrees + rng.randi_range(-25,25)
	
	rng.randomize()
	a.position = position + Vector2(rng.randi_range(-200, 200), 0).rotated(deg2rad(-direction_degrees))
	rng.randomize()
#	var val = rng.randf_range(2, 3.5)
#	a.scale *= val
	a.parallax_factor_x = parallax_factor_x
	
	if front:
		pass
	else:
		a.modulate = Color(.5,.5,.5)
	
	add_child(a)


func on_point():
#	print("increase asteroid speed")
	pass
