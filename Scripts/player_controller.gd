extends Area2D

var velocity = Vector2(0, 0)
var grav: float = 9.81
var jumpStr: float = -5.0
var screenSize

var gameController

# 
func _ready():
	gameController = get_tree().current_scene.get_node("GameController").get_script()
	get_tree().current_scene.get_node("GameController").get_script().debug()
	screenSize = get_viewport_rect().size
	_reset()

# Reset Player to Origin
func _reset():
	velocity = Vector2(0, 0)
	position = Vector2(-200, -screenSize.y/2)

func _process(delta):
	# Close Game
	if Input.is_key_pressed(KEY_ALT):
		get_tree().quit()
	
	# Add Velocity to Player
	if Input.is_action_just_pressed("jump"):
		velocity.y = jumpStr
	velocity.y += grav * delta
	
	# Keep Player Under Ceiling, Acting as Barrier
	if position.y <= -screenSize.y && velocity.y < 0:
		position.y = -screenSize.y
	# Vertical Player Movement When Possible
	else:
		position += velocity

# Detect Collision With Object
func _collided(area):
	print("Enter Collision With Object:", area.name)
	gameController.debug()
	pass
