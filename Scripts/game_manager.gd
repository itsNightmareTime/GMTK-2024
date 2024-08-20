extends Node

@onready var player_1: CharacterBody2D = $"../Players/Player1"
@onready var player_2: CharacterBody2D = $"../Players/Player2"
@onready var player_3: CharacterBody2D = $"../Players/Player3"
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var clock: Control = $"../Clock"

var level_one_finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_2d.transform.origin = Vector2(217, 128)
	
	player_1.transform.origin = Vector2(-70, 8)
	# set player 2 and 3 far far away
	player_2.transform.origin = Vector2(0, 1000)
	player_3.transform.origin = Vector2(0, 1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (level_one_finished):
		level_one_to_level_two()
		level_one_finished = false


func level_one_to_level_two():
	camera_2d.transform.origin = Vector2(867, 128)
	player_1.transform.origin = Vector2(600, 3)
	# set player 2 and 3 far far away
	player_2.transform.origin = Vector2(600, 120)
	player_3.transform.origin = Vector2(600, 250) #just testing if he can walk, player 3 shouldn't be visible here

func _on_finish_line_body_entered(body: Node2D) -> void:
	level_one_finished = true


func _on_finish_line_2_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
