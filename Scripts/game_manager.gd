extends Node

@onready var player_1: CharacterBody2D = $"../Players/Player1"
@onready var player_2: CharacterBody2D = $"../Players/Player2"
@onready var player_3: CharacterBody2D = $"../Players/Player3"
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var clock_3: Control = $"../Clock3"
@onready var finished_text: RichTextLabel = $Finished_text


var level_one_finished: bool = false
var current_level = "One"

var level_two_top_finished: bool = false
var level_two_mid_finished: bool = false

var level_three_top_finished: bool = false
var level_three_mid_finished: bool = false
var level_three_bot_finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_2d.transform.origin = Vector2(217, 128)
	player_1.transform.origin = Vector2(-70, 8)
	# set player 2 and 3 far far away
	player_2.transform.origin = Vector2(0, 1000)
	player_3.transform.origin = Vector2(0, 1000)
	finished_text.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (level_one_finished):
		level_one_to_level_two()
		level_one_finished = false
		
	if (level_two_top_finished and level_two_mid_finished):
		level_two_to_level_three()
		current_level = "two"
		level_two_top_finished = false
		level_two_mid_finished = false
		
	if (level_three_top_finished and level_three_mid_finished and level_three_bot_finished and not current_level == "three"):
		current_level = "three"
		level_three_top_finished = false
		level_three_mid_finished = false
		level_three_bot_finished = false
		level_three_finished()

func level_one_to_level_two():
	camera_2d.transform.origin = Vector2(872, 128)
	#clock.transform.origin = Vector2(500,-120)
	player_1.transform.origin = Vector2(600, 3)
	player_2.transform.origin = Vector2(600, 120)
	player_3.transform.origin = Vector2(0, 1000) # send 3 far far away
	
func level_two_to_level_three():
	camera_2d.transform.origin = Vector2(1528, 128)
	#clock.transform.origin = Vector2(1200,-120)
	player_1.transform.origin = Vector2(1250, 3)
	player_2.transform.origin = Vector2(1250, 120)
	player_3.transform.origin = Vector2(1250, 240) 

func level_three_finished():
	clock_3.visible = false
	finished_text.text = "Your Time was " + clock_3.get_time() + "! Press 'r' to restart or 'x' to quit"
	finished_text.visible = true

func _on_finish_line_body_entered(body: Node2D) -> void:
	level_one_finished = true
func _on_finish_line_top_body_entered(body: Node2D) -> void:
	level_two_top_finished = true
func _on_finish_line_mid_body_entered(body: Node2D) -> void:
	level_two_mid_finished = true
func _on_finish_line_3_top_body_entered(body: Node2D) -> void:
	level_three_top_finished = true
func _on_finish_line_3_mid_body_entered(body: Node2D) -> void:
	level_three_mid_finished = true
func _on_finish_line_3_bot_body_entered(body: Node2D) -> void:
	level_three_bot_finished = true
