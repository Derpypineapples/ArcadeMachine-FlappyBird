extends Node2D

var playerInst = preload("res://Objects/player.tscn")
var obsControllerInst = preload("res://Objects/obs_controller.tscn")

var player
var obsController

func _ready():
	#GameController = self
	player = playerInst.instantiate() 
	obsController = obsControllerInst.instantiate()
	add_child(player)
	add_child(obsController)
	debug()
	player.get_script()._reset()

func debug():
	print("Running Debug Func in Script")

func _end_game():
	print("Ending Game...")
	#obsController.get_script()._reset()
	player.get_script()._reset()
	pass
