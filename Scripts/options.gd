extends Control

var main_index: int
var music_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	main_index = AudioServer.get_bus_index('Master')
	music_index = AudioServer.get_bus_index('Music')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(main_index, linear_to_db(value))

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value))
