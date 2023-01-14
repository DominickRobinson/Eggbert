extends Camera2D

export (NodePath) var player_node_path := ""
export (String, FILE) var wall_filepath := "res://Scenes/Props/Pipes/Pipe.tscn"
export (Array, int) var wall_spawn_range := [0,0]

onready var player = get_node(player_node_path)
var wallResource

var starting_y
var random = RandomNumberGenerator.new()

func _ready():
	starting_y = global_position.y
	wallResource = load(wall_filepath)

func _physics_process(delta):
	if is_instance_valid(player):
		global_position.x = player.global_position.x
	global_position.y = starting_y
	


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
