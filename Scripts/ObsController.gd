extends Node2D

var screenSize : Vector2
var obstacle = preload("res://Objects/obstacle.tscn")
var obsList = []

var imgSize : int = 32
var obsScale : int = 4

var obsTimer = 0.0
var spawnTimer = 5.0

var obsSpeed = 120
var obsGap = 200
var obsGapPos

var screenOffset : int = 50
func _ready():
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
			
		else:
			var sign: int = c.position.y / abs(c.position.y)
			
			# Update Position And Scale of Pipe Body
			c.position.y = (sign * screenSize.y)/obsScale + (sign * obsGap/4) + obsGapPos/2
			c.scale.y = (screenSize.y - obsGap - sign*obsGapPos*2)/(2 * 96)
	
	# Add Object to List
	add_child(obsInst)
	obsList.append(obsInst) 

func _reset():
	for o in obsList:
		remove_child(o)
		
	obsTimer = 0
	obsSpeed = 120
	obsGap = 200
	_instObs()

func _process(delta):
	for o in obsList:
		# Move Obstacles at Determined Speed
		o.position.x -= obsSpeed * delta
		
		# Instantate New Obstacle Based on Time
		if obsTimer >= spawnTimer:
			_instObs()
			obsTimer = 0
			
		# Remove Obstacles Off Screen
		if o.position.x < -(screenSize.x/2 + screenOffset):
			remove_child(o)
	
	# Increase Timer
	obsTimer += delta
