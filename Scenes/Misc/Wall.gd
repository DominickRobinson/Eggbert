extends StaticBody2D

export (String, "red", "green", "ice_blue", "purple", "yellow", "blue", "orange") var color := "red"

var filepath = "res://Assets/Props/Pipes/pipe-%s.png"

onready var us = $Upper/Sprite
onready var ls = $Lower/Sprite


func _ready():
	change_color(color)


func change_color(c):
	self.color = c
	var file = filepath % color
	print(file)
	$Lower/Sprite.texture = load(file)
	$Upper/Sprite.texture = load(file)


func _on_Sensor_area_entered(area):
	print("point!")
	GameManager.increment_score()



func _on_Sensor_body_entered(body):
	print("point!!!")
	if body.is_in_group("Players"):
		if body.alive:
			GameManager.increment_score()
		else:
			body.die()
