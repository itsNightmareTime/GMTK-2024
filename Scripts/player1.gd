extends CharacterBody2D

const SPEED = 10000.0
const RUN_SPEED = SPEED * 1.5
@onready var animated_sprite = $AnimatedSprite2D
@onready var detect_interaction: RayCast2D = $Detect_Interaction

var last_direction = "Down"
var detect_interaction_length: int = 1
var detect_interaction_direction: Vector2 = Vector2(0,1)

var player = "Player_One_"

func _process(delta):
	# can switch between running and walking speeds
	var current_speed = SPEED
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed(player + "Interact"):
		Interaction()
	
	#if Input.is_action_pressed(player + "Run"):
	current_speed = RUN_SPEED

	#Get Action
	if Input.is_action_pressed(player + "Up"):
		velocity.y -= current_speed
		last_direction = "Up"
		detect_interaction.target_position = Vector2(0, -detect_interaction_length)
		
	if Input.is_action_pressed(player + "Down"):
		velocity.y += current_speed
		last_direction = "Down"
		detect_interaction.target_position = Vector2(0, detect_interaction_length)
		
	if Input.is_action_pressed(player + "Right"):
		velocity.x += current_speed
		last_direction = "Right"
		detect_interaction.target_position = Vector2(detect_interaction_length, 0)
		
	if Input.is_action_pressed(player + "Left"):
		velocity.x -= current_speed
		last_direction = "Left"
		detect_interaction.target_position = Vector2(-detect_interaction_length, 0)

	# Handle opposite directions
	if Input.is_action_pressed(player + "Up") and Input.is_action_pressed(player + "Down"):
		velocity.y = 0
	if Input.is_action_pressed(player + "Left") and Input.is_action_pressed(player + "Right"):
		velocity.x = 0

	# Move
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * current_speed * delta
		animated_sprite.play(last_direction)
	else:
		animated_sprite.play(last_direction + "_Idle")

	move_and_slide()
	
func Interaction():
	if detect_interaction.is_colliding():
		#print("touchy touch touch")
		var the_object = detect_interaction.get_collider()
		print("the object we touched was: " + the_object.name)
	else:
		print("no touchy")
