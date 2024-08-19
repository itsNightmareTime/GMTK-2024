extends RigidBody2D

var previous_position: Vector2
var sound_player: AudioStreamPlayer2D
var is_finished_playing: bool = false

# Sound can fuck off for right now
func _ready():
	pass
	#previous_position = position  
	#sound_player = $AudioStreamPlayer2D

func _physics_process(delta):
	pass
	# Check if the box's position has changed
	#if position != previous_position and !sound_player.playing and !is_finished_playing:
		#sound_player.play()
		# Update the previous position
		#previous_position = position
		#is_finished_playing = false

func _on_audio_stream_player_2d_finished() -> void:
	pass
	#is_finished_playing = true
