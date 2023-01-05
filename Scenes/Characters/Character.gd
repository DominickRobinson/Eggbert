extends KinematicBody2D
class_name Character

export var MAX_FALL_SPEED := 400
export var HORIZONTAL_SPEED := 125
var og_horizontal_speed = HORIZONTAL_SPEED
export var GRAVITY := 5
var DEATH_GRAVITY = 1.5 * GRAVITY

const UP = Vector2(0,-1)

onready var anim = $AnimationPlayer

var motion = Vector2()
var alive = true



func _physics_process(delta):
	if alive:
		motion.y += GRAVITY
		if motion.y > MAX_FALL_SPEED:
			motion.y = MAX_FALL_SPEED
		motion = move_and_slide(motion, UP)
	else:
		motion.y += DEATH_GRAVITY
		motion = move_and_slide(motion, UP)

func die():
	alive = false
	anim.stop()
	anim.play("death")
	motion.y = -400
	motion.x = 0
	GRAVITY = 20











#func add_shaders():
#	for s in sprites:
#		s.material = ShaderMaterial.new()
#		s.material.shader = MotionBlurShader
#
#func increase_shader():
#	for s in sprites:
#		print(s.name)
#		var shader = s.material as Shader
#		print(shader)
#		shader.set_shader_param("dir", calculate_blur())
#
#func calculate_blur():
#	var x = stepify((motion.x - og_horizontal_speed), 20) * 0.002
#	var x = int(motion.x - og_horizontal_speed)/20 * 0.02
#	x = clamp(x, 0, 1)
#	var y = 0
#	return Vector2(x,y)

#func get_all_sprites(in_node,arr:=[]):
#	#print("Currently checking: ", in_node, ". Here are its children: ", in_node.get_children())
#	for child in in_node.get_children():
#		arr = get_all_sprites(child,arr)
#	if in_node is Sprite and in_node.get_name():
#		#(in_node.get_name(), " is a Sprite!!!")
#		arr.push_back(in_node)
#	return arr
