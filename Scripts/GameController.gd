extends Node2D

var playerInst = preload("res://Objects/player.tscn")
var obsControllerInst = preload("res://Objects/obs_controller.tscn")

var player
var obsController

var debug_var = "Debug Variable"

var score: int = 0

func _ready():
	player = playerInst.instantiate() 
	obsController = obsControllerInst.instantiate()
	
	add_child(player)
	add_child(obsController)
	
	player._reset()

# End Game And Broadcast Reset to Player and Obstacle Controller
func _end_game():
	obsController._reset()
	player._reset()
	score = 0
	pass
