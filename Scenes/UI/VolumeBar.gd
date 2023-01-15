extends VBoxContainer

export var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)

onready var slider = $HSlider
onready var label = $Label

func _ready() -> void:
	slider.connect("value_changed", self, "_on_value_changed")
	slider.value = MusicManager.current_volume
	_on_value_changed(MusicManager.current_volume)


func _on_value_changed(value: float) -> void:
	MusicManager.current_volume = value
	label.text = "Volume: " + str(int(value * 100)) + "%"
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
