extends CharacterBody2D

enum PLAYER_NUM {
	ONE = 1,
	TWO = 2,
	THREE = 3
}
const SPEED = 15000.0
const BLOCK_PULL_SPEED: float = 0.75
const BLOCK_PUSH_SCALAR: float = 2.75
const BLOCK_FRICTION: float = 0.3 #determines how long it takes to push/pull before the block starts moving
const BLOCK_NAME: String = "Movable_Object"

@export var PLAYER_NUMBER: PLAYER_NUM = PLAYER_NUM.ONE
@onready var animated_sprite = $AnimatedSprite2D
@onready var my_detect_interaction: RayCast2D = get_node(PLAYER_NAMES[PLAYER_NUMBER] + "RayCast2D")

var object_collision_layer_name: String = ""
var block_contact_time: float = 0.0
var last_direction = "Right"
var detect_interaction_length: int = 1
var detect_interaction_direction: Vector2 = Vector2(0,1)

const PLAYER_NAMES = {
	1: 'Player_One_',
	2: 'Player_Two_',
	3: 'Player_Three_'	
}

func _process(delta):
	
	#restart the game
	if (Input.is_action_pressed("reload")):
		get_tree().change_scene_to_file('res://Scenes/menu.tscn')
		
	if (Input.is_action_pressed("quit")):
		get_tree().quit()
	
	var current_speed = SPEED
	velocity = Vector2.ZERO
	
	handle_block_push(delta)
	handle_interaction()	
	velocity = handle_directional_input(current_speed)
	
	# Move
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * current_speed * delta
		animated_sprite.play(last_direction)
	else:
		animated_sprite.play(last_direction + "_Idle")

	move_and_slide()
	
func handle_block_push(delta):
	# check if there is a collision
	if not check_collisions():
		return
	
	# if its colliding with a box and the player is pushing it
	if Input.is_anything_pressed():
		var colliding_object = my_detect_interaction.get_collider()
		block_contact_time += delta
		# once push time exceeds block friction, it can start moving
		if block_contact_time >= BLOCK_FRICTION:
			var block = my_detect_interaction.get_collider()
			if block and block is RigidBody2D:
				var the_block: RigidBody2D = block
				the_block.move_and_collide(direction_to_vector2D()/BLOCK_PUSH_SCALAR)
	# Player is either not touching a block or not holding a direction towards it
	else:
		block_contact_time = 0.0

func handle_directional_input(current_speed: float) -> Vector2:
	var new_velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Up"):
		new_velocity.y -= current_speed
		last_direction = "Up"
		my_detect_interaction.target_position = Vector2(0, -detect_interaction_length)
		
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Down"):
		new_velocity.y += current_speed
		last_direction = "Down"
		my_detect_interaction.target_position = Vector2(0, detect_interaction_length)
		
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Right"):
		new_velocity.x += current_speed
		last_direction = "Right"
		my_detect_interaction.target_position = Vector2(detect_interaction_length, 0)
		
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Left"):
		new_velocity.x -= current_speed
		last_direction = "Left"
		my_detect_interaction.target_position = Vector2(-detect_interaction_length, 0)

	# Handle opposite directions
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Up") and Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Down"):
		new_velocity.y = 0
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Left") and Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Right"):
		new_velocity.x = 0
	
	return new_velocity
			
func handle_interaction():
	if Input.is_action_pressed(PLAYER_NAMES[PLAYER_NUMBER] + "Interact"):
		if my_detect_interaction.is_colliding():
			#print("touchy touch touch")
			var the_object = my_detect_interaction.get_collider()
			print("the object we touched was: " + the_object.name)
		else:
			print("no touchy")
			
func check_collisions() -> bool:
	if my_detect_interaction.is_colliding():
		object_collision_layer_name = my_detect_interaction.get_collider().name
		return true
	else:
		object_collision_layer_name = ""
		return false
		
func direction_to_vector2D() -> Vector2:
	if last_direction == "Up":
		return Vector2.UP
	elif last_direction == "Down":
		return Vector2.DOWN
	elif last_direction == "Right":
		return Vector2.RIGHT
	else:
		return Vector2.LEFT
