extends Node2D

var playerInst = preload("res://Objects/player.tscn")
var obsControllerInst = preload("res://Objects/obs_controller.tscn")
var uiControllerInst = preload("res://Objects/ui.tscn")

var player
var obsController
var uiController

var debug_var = "Debug Variable"

var score: int = 0
var highscore

var file = FileAccess.open("user://myfile.name", FileAccess.READ)
var save_path = "user://score.save"

func _ready():
	uiController = uiControllerInst.instantiate()
	player = playerInst.instantiate() 
	obsController = obsControllerInst.instantiate()
	
	add_child(player)
	add_child(obsController)
	add_child(uiController)
	
	load_score()
	
	player.reset()

# End Game And Broadcast Reset to Player and Obstacle Controller
func _end_game():
	print("Ending Game")
	obsController.toggle_movement(false)
	player.toggle_movement(false)
	uiController.toggle_screen(1, true)

func update_score():
	score += 1
	if score > highscore: highscore = score
	obsController.update_variables(score)

func save_score():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(score)
	uiController.load_score_text(highscore)

func load_score():
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		highscore = file.get_var()
	else:
		print("file not found")
		highscore = 0
	
	uiController.load_score_text(highscore)

func restart_game():
	obsController.reset()
	player.reset()
	score = 0

func start_game():
	obsController.toggle_movement(true)
	player.toggle_movement(true)
