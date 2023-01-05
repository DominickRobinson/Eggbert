extends StaticBody2D



func _on_Sensor_area_entered(area):
	print("point!")
	GameManager.increment_score()



func _on_Sensor_body_entered(body):
	print("point!!!")
	GameManager.increment_score()
