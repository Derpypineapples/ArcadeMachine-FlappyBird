extends Area2D

var velocity = Vector2(0, 0)
var grav: float = 9.81
var jumpStr: float = -5.0
var screenSize

func _ready():
	screenSize = get_viewport_rect().size

# Reset Player to Origin
func _reset():
	print("Reseting Player to Origin...")
	velocity = Vector2(0, 0)
	position = Vector2(-200, -screenSize.y/2 - 150)

func _process(delta):
	# Close Game
	if Input.is_key_pressed(KEY_ALT):
		get_tree().quit()
	
	# Keep Player Under Ceiling, Acting as Barrier
	if position.y <= -screenSize.y && velocity.y < 0:
		position.y = -screenSize.y
	# Vertical Player Movement When Possible
	else:
		position += velocity

func _physics_process(delta):
	# Add Velocity to Player
	if Input.is_action_just_pressed("jump"):
		velocity.y = jumpStr
	velocity.y += grav * delta

# Detect Collision With Object
func _collided(area):
	print("Enter Collision With Object:", area.name)
	if area.name == "CrossCollider":
		print("Player Crossed Pipes")
		GameController.score += 1
		print(GameController.score)
	else:
		print("Player Collided With Pipes")
		GameController._end_game()
	pass
