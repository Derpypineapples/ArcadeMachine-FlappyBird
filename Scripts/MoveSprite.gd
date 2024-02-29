extends Area2D

var velocity = Vector2(0, 0)
var grav: float = 9.81
var jumpStr: float = -5.0
var screenSize

var gameController

func _ready():
	gameController = get_tree().current_scene.get_node("GameController").get_script()
	get_tree().current_scene.get_node("GameController").get_script().debug()
	screenSize = get_viewport_rect().size
	_reset()

func _reset():
	velocity = Vector2(0, 0)
	position = Vector2(-200, -screenSize.y/2)

func _process(delta):	
	if Input.is_key_pressed(KEY_ALT):
		get_tree().quit()
	
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_SPACE):
		velocity.y = jumpStr
	velocity.y += grav * delta
	
	if position.y > 0:
		gameController._end_game()
		#_reset()
	
	position += velocity

func _collided(area):
	print("Enter Collision With Object:", area.name)
	gameController.debug()
	pass
