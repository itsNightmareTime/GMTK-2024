extends Control

@export var start_seconds: int = 30
@export var start_minutes: int = 1
var current_seconds: int
var current_minutes: int
@onready var timer_text: Label = $Label
@onready var timer: Timer = $Timer

func _ready() -> void:
	Reset_Timer()
	timer.start()

func Reset_Timer():
	current_seconds = start_seconds
	current_minutes = start_minutes
	set_text()

func set_text():
	timer_text.text = str(current_minutes) + ":" + str(current_seconds).pad_zeros(2)

func get_time() -> String:
	return str(current_minutes) + ":" + str(current_seconds).pad_zeros(2)

func _on_timer_timeout() -> void:
	if current_seconds == 59:
		current_minutes += 1
		current_seconds = 0
	else:
		current_seconds += 1
	set_text()
