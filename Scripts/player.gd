extends CharacterBody2D

enum PLAYER_NUM {
	ONE = 1,
	TWO = 2,
	THREE = 3
}
const SPEED = 10000.0
const RUN_SPEED = SPEED * 1.5
const BLOCK_SPEED = 0.005
var block_contact_time: float = 0.0
@export var PLAYER_NUMBER: PLAYER_NUM = PLAYER_NUM.ONE

@onready var animated_sprite = $AnimatedSprite2D
@onready var detect_interaction: RayCast2D = $Detect_Interaction


var last_direction = "Down"
var detect_interaction_length: int = 1
var detect_interaction_direction: Vector2 = Vector2(0,1)

const PLAYER_NAMES = {
	1: 'Player_One_',
	2: 'Player_Two_',
	3: 'Player_Three_'	
}

func _process(delta):
	
	
	push_block(delta)
	
	# can switch between running and walking speeds
	var current_speed = SPEED
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Interact"):
		Interaction()
	
	#if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER + "Run"):
	current_speed = RUN_SPEED

	#Get Action
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Up"):
		velocity.y -= current_speed
		last_direction = "Up"
		detect_interaction.target_position = Vector2(0, -detect_interaction_length)
		
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Down"):
		velocity.y += current_speed
		last_direction = "Down"
		detect_interaction.target_position = Vector2(0, detect_interaction_length)
		
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Right"):
		velocity.x += current_speed
		last_direction = "Right"
		detect_interaction.target_position = Vector2(detect_interaction_length, 0)
		
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Left"):
		velocity.x -= current_speed
		last_direction = "Left"
		detect_interaction.target_position = Vector2(-detect_interaction_length, 0)

	# Handle opposite directions
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Up") and Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Down"):
		velocity.y = 0
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Left") and Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Right"):
		velocity.x = 0

	# Move
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * current_speed * delta
		animated_sprite.play(last_direction)
	else:
		animated_sprite.play(last_direction + "_Idle")

	move_and_slide()
	
func push_block(delta):
	# Check for block contact
	if detect_interaction.is_colliding() and not no_input():
		block_contact_time += delta
	else:
		block_contact_time = 0.0
		
	if block_contact_time >= 0.2:
		var block = detect_interaction.get_collider()
		if block and block is RigidBody2D:
			#var push_force = velocity.normalized() * BLOCK_SPEED
			#block.apply_central_impulse(push_force)
			var the_block: RigidBody2D = block
			the_block.move_and_collide(Direction_To_Vector2D()/2)
		
func Interaction():
	if detect_interaction.is_colliding():
		#print("touchy touch touch")
		var the_object = detect_interaction.get_collider()
		print("the object we touched was: " + the_object.name)
	else:
		print("no touchy")
		
func Direction_To_Vector2D() -> Vector2:
	if last_direction == "Up":
		return Vector2.UP
	elif last_direction == "Down":
		return Vector2.DOWN
	elif last_direction == "Right":
		return Vector2.RIGHT
	else:
		return Vector2.LEFT
		
func no_input() -> bool:
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Up"):
		return false
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Down"):
		return false
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Right"):
		return false
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Left"):
		return false
	return true

	
		

		

		
		
