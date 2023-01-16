extends KinematicBody2D
class_name Character

export var MAX_FALL_SPEED := 400
export var HORIZONTAL_SPEED := 125
var og_horizontal_speed = HORIZONTAL_SPEED
export var GRAVITY := 5
export var DEATH_MOTION_Y := -300

const UP = Vector2(0,-1)

onready var anim = $AnimationPlayer
onready var detect = $Detect

const bubble_normal_path = preload("res://Scenes/SpeechBubbles/BubbleNormal.tscn")
const bubble_thought_path = preload("res://Scenes/SpeechBubbles/BubbleThought.tscn")
const bubble_yell_path = preload("res://Scenes/SpeechBubbles/BubbleYell.tscn")

var motion = Vector2()
var alive = true

var mee = true
var mee_path = "res://Assets/SoundEffects/mee.mp3"
var mo_path = "res://Assets/SoundEffects/mo.mp3"

var time_to_die = 4.0

func _init():
	GameManager.score = 0
	GameManager.connect("point", self, "_on_point")
	
	yield(self, "ready")
	if is_instance_valid($Detect):
		$Detect.connect("body_entered", self, "_on_obstacle_collision")
	if is_instance_valid($AnimationPlayer):
		$AnimationPlayer.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")


func _physics_process(delta):
	if not alive:
		motion.x = lerp(motion.x, 0, .02)
		motion.y += GRAVITY
		motion = move_and_slide(motion, UP)

func die(time=time_to_die):
	alive = false
	anim.stop()
	anim.play("death")
	motion.y = DEATH_MOTION_Y
	motion.x = -HORIZONTAL_SPEED
	$Detect.collision_layer = 0
	$Detect.collision_mask = 0
#	GameManager.play_audio("res://Assets/SoundEffects/ow.mp3", 10)
	lose_popup(time)


func lose_popup(time):
	yield(get_tree().create_timer(time), "timeout")
	GameManager.lose()

func _on_obstacle_collision(body):
	if not alive:
		return
	if body.is_in_group("Obstacles"):
		die()



func mee_moo():
	if mee:
		GameManager.play_audio(mee_path, 15)
	else:
		GameManager.play_audio(mo_path, 20)
	mee = not mee

func speak(text, time, type):
	var bubble
	var src
	match type:
		"normal":
			src = bubble_normal_path
		"thought":
			src = bubble_thought_path
		"yell":
			src = bubble_yell_path
		_:
			return false
	
	bubble = src.instance()
	add_child(bubble)
	bubble.prepare(text, time)





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
