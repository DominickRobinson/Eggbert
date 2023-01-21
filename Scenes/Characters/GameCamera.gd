extends Camera2D

export (NodePath) var player_node_path := ""
export (String, FILE) var wall_filepath := "res://Scenes/Props/Pipes/Pipe.tscn"
export (Array, int) var wall_spawn_range := [0,0]

export var following_x := true
export var following_y := false

onready var player = get_node(player_node_path)
var wallResource
var random = RandomNumberGenerator.new()

#shake stuff
export var decay := 0.7  # How quickly the shaking stops [0, 1].
export var max_offset := Vector2(100, 64)  # Maximum hor/ver shake in pixels.
export var max_roll := 1.1  # Maximum rotation in radians (use sparingly).
#export (NodePath) var target  # Assign the node this camera will follow.

var trauma = 0.0  # Current shake strength.
var trauma_power = 3 # Trauma exponent. Use [2, 3].

onready var noise = OpenSimplexNoise.new()
var noise_y = 0



func _ready():
	wallResource = load(wall_filepath)
	limit_left = global_position.x - 512
	#shake stuff
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
	if is_instance_valid(player):
		player.connect("die", self, "add_trauma", [1])


func _physics_process(delta):
	if Input.is_action_just_pressed("a"):
#		add_trauma(1)
		zoom *= 1.1
	
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
	if following_x:
		follow_x()
	
	if following_y:
		follow_y()


func follow_x():
	if is_instance_valid(player):
		global_position.x = player.global_position.x

func follow_y():
	if is_instance_valid(player):
		global_position.y = player.global_position.y

func change_y(value : int):
	global_position.y = value


func _on_Reset_body_entered(body):
	if body.is_in_group("Obstacles"):
		var color = body.color
		
		var walls = body.get_parent()
		
		var instance = wallResource.instance()
		instance.change_color(color)
		walls.add_child(instance)
		
		random.randomize()
		instance.global_position.x = global_position.x + 200 + abs(abs($Reset.global_position.x) - abs(global_position.x))
		instance.global_position.y = global_position.y + random.randi_range(wall_spawn_range[0], wall_spawn_range[1])
		
		body.queue_free()


func add_trauma(amount):
	print("adding trauma")
	trauma = min(trauma + amount, 1.0)

func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
