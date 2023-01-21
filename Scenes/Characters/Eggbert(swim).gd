extends Character

export var SWIM_SPEED := 500

var float_playback_speed
var click_position = global_position

var swim = false

var maskResource = preload("res://Scenes/Props/Mask.tscn")
onready var mask

const splashResource = preload("res://Scenes/Particles/SplashCPU.tscn")


func _ready():
	scuba_mask()
	GameManager.mode = GameManager.GameModes.SWIM

func _physics_process(delta):
	if not started:
		return
	swim = $Touch/Button.pressed
	if alive:
		swim(delta)
		motion.x = HORIZONTAL_SPEED
		motion = move_and_slide(motion, UP)
	
func scuba_mask():
	mask = maskResource.instance()
	$Body/Head.add_child(mask)
	mask.position += $Body/Head.offset

func splash():
	var s = splashResource.instance()
	get_parent().add_child(s)
	s.global_position = global_position
	s.global_position.y -= 20

func swim(delta):
	if swim:
		click_position = get_global_mouse_position()
		motion.y = (click_position.y - global_position.y) * SWIM_SPEED * delta
		rotation = motion.angle() + PI/2
		yield(self,"ready")
		anim.playback_speed = float_playback_speed*2
	else:
		motion.y = 0
		yield(self,"ready")
		anim.playback_speed = float_playback_speed

func die(time=time_to_die):
	.die(time)
	
	$Swishing.stop()
	
	mask.queue_free()
	
	yield(get_tree(), "physics_frame")
	mask = maskResource.instance()
	get_tree().get_current_scene().add_child(mask)
	mask.floating = true
	mask.scale.x *= $Body.scale.x * 1.2
	mask.scale.y *= $Body.scale.y * 1.2
	mask.global_position = $Body/Head.global_position

	speak("*gargles*", 3, "yell")
	GameManager.play_audio("res://Assets/SoundEffects/gargle.mp3", 15)
	$Body/Head/Beak/Bubbles.emitting = true



func _on_point():
	HORIZONTAL_SPEED *= 1.02
	SWIM_SPEED *= 1.02

func _on_animation_changed(old_name, new_name):
	if new_name == "swim":
		anim.playback_speed = float_playback_speed
	else:
		anim.playback_speed = 1
