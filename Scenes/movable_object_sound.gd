extends RigidBody2D

var previous_position: Vector2
var sound_player: AudioStreamPlayer2D
var is_sound_playing: bool = false

func _ready():
	previous_position = position  
	sound_player = $AudioStreamPlayer2D

func _process(delta):
	# Check if the box's position has changed
	if position != previous_position:
		if not is_sound_playing:
			#sound_player.play() # currently the sound is awful and this isn't working very well...
			is_sound_playing = true
		# Update the previous position
		previous_position = position
	else:
		is_sound_playing = false
