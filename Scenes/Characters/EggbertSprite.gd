extends Node2D

export var animation := "wave"

onready var anim = $AnimationPlayer

func _ready():
	yield(self, "ready")
	anim.connect("animation_started", self, "_on_animation_started")
	anim.connect("animation_finished", self, "_on_animation_finished")
	anim.connect("animation_changed", self, "_on_animation_changed")
	anim.play(animation)


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
