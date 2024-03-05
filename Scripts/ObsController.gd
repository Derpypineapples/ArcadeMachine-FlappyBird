extends Node2D

var screenSize: Vector2
var obstacle = preload("res://Objects/obstacle.tscn")
var obsList = []

var imgSize: int = 32
var obsScale: int = 4

var obsTimer = 0.0
var spawnTimer = 3.0

var obsSpeed = 200
var obsGap = 200
var obsGapPos
var movement_toggle: bool = false

var screenOffset: int = 50

var player_x: float

func _ready():
	player_x = GameController.player.position.x
	_instObs()

# Instantiate new obstacle off screen & append to list
func _instObs():
	screenSize = get_viewport_rect().size
	
	# Instantiate Object And Set Offscreen Zero
	var obsInst = obstacle.instantiate()
	obsInst.position = Vector2(screenSize.x/2 + screenOffset, -screenSize.y/2)
	
	# Set Gap Position Randomly
	var obsGapPos = randf_range(-screenSize.y/2 + 1, screenSize.y/2 - 1)/2
	
	# Iterate Through Objects to Scale And Position
	for c in obsInst.get_children():
		if c.name == "Caps":
			for o in c.get_children():
				var sign: int = o.position.y / abs(o.position.y)
				o.position.y = obsGapPos + (sign * obsGap/2)
				
		elif c.name == "GapPos":
			c.position.y = obsGapPos
		
		elif c.name == "CrossCollider":
			c.scale.y = screenSize.y
			
		else:
			var sign: int = c.position.y / abs(c.position.y)
			
			# Update Position And Scale of Pipe Body
			c.position.y = (sign * screenSize.y)/obsScale + (sign * obsGap/4) + obsGapPos/2
			c.scale.y = (screenSize.y - obsGap - sign*obsGapPos*2)/(2 * 96)
	
	# Add Object to List
	add_child(obsInst)
	obsList.append(obsInst) 

func reset():
	for o in obsList:
		remove_child(o)
	
	movement_toggle = true
	obsTimer = 0.0
	
	_instObs()

func toggle_movement(toggle: bool):
	movement_toggle = toggle

func _process(delta):
	# Disable All Movement Related Activities
	if !movement_toggle: return
	
	for i in obsList.size():
		# Skip over invalid Indicies
		if i >= obsList.size(): break
		
		# Current Object Being Manipulated
		var o = obsList[i]
		
		# Move Obstacles at Determined Speed
		o.position.x -= obsSpeed * delta
		
		# Remove Obstacles Off Screen
		if o.position.x < -(screenSize.x/2 + screenOffset):
			obsList.remove_at(i)
			o.queue_free()
	
	# Instantate New Obstacle Based on Time
	if obsTimer >= spawnTimer:
		_instObs()
		obsTimer = 0
	
	# Increase Timer
	obsTimer += delta
