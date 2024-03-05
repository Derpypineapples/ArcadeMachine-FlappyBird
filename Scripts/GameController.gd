extends Node2D

var playerInst = preload("res://Objects/player.tscn")
var obsControllerInst = preload("res://Objects/obs_controller.tscn")
var uiControllerInst = preload("res://Objects/ui.tscn")

var player
var obsController
var uiController

var debug_var = "Debug Variable"

var score: int = 0

func _ready():
	uiController = uiControllerInst.instantiate()
	player = playerInst.instantiate() 
	obsController = obsControllerInst.instantiate()
	
	add_child(player)
	add_child(obsController)
	add_child(uiController)
	
	player.reset()

# End Game And Broadcast Reset to Player and Obstacle Controller
func _end_game():
	print("Ending Game")
	obsController.toggle_movement(false)
	player.toggle_movement(false)
	uiController.toggle_screen(1, true)

func restart_game():
	obsController.reset()
	player.reset()
	score = 0

func start_game():
	obsController.toggle_movement(true)
	player.toggle_movement(true)
