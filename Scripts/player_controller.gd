extends Area2D

var velocity = Vector2(0, 0)
var grav: float = 9.81
var jumpStr: float = -5.0
var screenSize

var movement_toggle
var idle_toggle: bool = true

var current_time = Time.get_time_dict_from_system()

func _ready():
	screenSize = get_viewport_rect().size
	movement_toggle = false

# Reset Player to Origin
func reset():
	print("Reseting Player to Origin...")
	if !idle_toggle:
		movement_toggle = true
	velocity = Vector2(0, 0)
	position = Vector2(-100, -screenSize.y/2 - 150)

func toggle_movement(toggle: bool):
	movement_toggle = toggle
	idle_toggle = false

func _movement(delta):
	# Keep Player Under Ceiling, Acting as Barrier
	if position.y <= -screenSize.y && velocity.y < 0:
		position.y = -screenSize.y
	# Vertical Player Movement When Possible
	else:
		position += velocity
		
func _idle_movement(delta):
	position.y = sin(Time.get_unix_time_from_system() * 1.5) * 75 - screenSize.y/2

func _process(delta):
	# Close Game
	if Input.is_key_pressed(KEY_ALT):
		get_tree().quit()
	
	if movement_toggle: _movement(delta)
	elif idle_toggle: _idle_movement(delta)

func _physics_process(delta):
	if !movement_toggle: return
	# Add Velocity to Player
	if Input.is_action_just_pressed("jump"):
		velocity.y = jumpStr
	velocity.y += grav * delta

# Detect Collision With Object
func _collided(area):
	print("Enter Collision With Object:", area.name)
	if area.name == "CrossCollider":
		print("Player Crossed Pipes")
		GameController.update_score()
		print(GameController.score)
	else:
		print("Player Collided With Pipes")
		GameController._end_game()
	pass
