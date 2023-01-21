extends KinematicBody2D
class_name Character

export (String, "flappy", "glide", "swim", "anti-gravity", "none") var cutscene := "none"

export var MAX_FALL_SPEED := 400
export var HORIZONTAL_SPEED := 125
var og_horizontal_speed = HORIZONTAL_SPEED
export var GRAVITY := 5
export var DEATH_MOTION_Y := -300

const UP = Vector2(0,-1)

onready var anim = $AnimationPlayer
onready var detect = $Detect
onready var cutscene_anim = $Cutscene

const bubble_normal_path = preload("res://Scenes/SpeechBubbles/BubbleNormal.tscn")
const bubble_thought_path = preload("res://Scenes/SpeechBubbles/BubbleThought.tscn")
const bubble_yell_path = preload("res://Scenes/SpeechBubbles/BubbleYell.tscn")

var motion = Vector2()
var alive = true

var mee = true
var mee_path = "res://Assets/SoundEffects/mee.mp3"
var mo_path = "res://Assets/SoundEffects/mo.mp3"

var time_to_die = 4.0
var started = false

var flaps = 0

signal die

func _init():
	GameManager.score = 0
	GameManager.connect("point", self, "_on_point")
	yield(self, "ready")
	cutscene_anim.reset_cutscene(cutscene)
	
	anim.play("wave")
	detect.connect("body_entered", self, "_on_obstacle_collision")
	anim.connect("animation_started", self, "_on_animation_started")
	anim.connect("animation_finished", self, "_on_animation_finished")
	anim.connect("animation_changed", self, "_on_animation_changed")

func play_cutscene():
	cutscene_anim.play_cutscene(cutscene)

func skip_cutscene():
	flaps += 1
	if flaps > 1:
		$Cutscene.playback_speed = 5

func _physics_process(delta):
	if not started and (Input.is_action_just_pressed("flap") or Input.is_action_just_pressed("left_mouseclick")):
		skip_cutscene()
	if not alive:
		motion.x = lerp(motion.x, 0, .02)
		motion.y += GRAVITY
		motion = move_and_slide(motion, UP)

func die(time=time_to_die):
	emit_signal("die")
	alive = false
	anim.stop()
	anim.play("death")
	motion.y = DEATH_MOTION_Y
	motion.x = -HORIZONTAL_SPEED
	detect.collision_layer = 0
	detect.collision_mask = 0
	lose_popup(time)


func lose_popup(time):
	yield(get_tree().create_timer(time), "timeout")
	GameManager.lose()

func _on_obstacle_collision(body):
	if not alive:
		return
	if body.is_in_group("Obstacles"):
		GameManager.play_audio("res://Assets/SoundEffects/hit.mp3", 10)
		die()



func mee_moo():
	if mee:
		GameManager.play_audio(mee_path, 15)
	else:
		GameManager.play_audio(mo_path, 20)
	mee = not mee

func speak(text : String, time : float, type : String):
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


func _on_animation_started(anim_name):
	if anim_name == "RESET":
		return
	print("RESET")
	
	anim.play("RESET")
	anim.disconnect("animation_started", self, "_on_animation_started")
	yield(anim, "animation_finished")
	print(anim_name)
	anim.play(anim_name)
	anim.connect("animation_started", self, "_on_animation_started")


func _on_animation_finished(anim_name):
	pass

func _on_animation_changed(old_anim_name, new_anim_name):
	pass


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
