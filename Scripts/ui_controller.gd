extends Node

var score_label
var screen_list

var quick_select = true
var button_list

func _ready():
	score_label = get_child(0).get_child(0)
	screen_list = get_children()

func _process(delta):
	score_label.text = "[center]%s[/center]" % str(GameController.score)
	
	if !screen_list[1].visible and !screen_list[2].visible: return
	
	# Get List of Active Buttons For Convenience
	
	# Manage Inputs to Select Buttons
	# Select Reset or Start Button
	if Input.is_action_just_pressed("up_selector"):
		quick_select = false
		button_list[1].grab_focus()
		if Input.is_action_just_pressed("accept"):
			if screen_list[1].visible: _button_reset()
			elif screen_list[2].visible: _button_start()
	# Select Quit Button
	elif Input.is_action_just_pressed("down_selector"):
		quick_select = false
		button_list[2].grab_focus()
		if Input.is_action_just_pressed("accept"): _button_quit()
	
	# Quick Access to Quit
	if quick_select:
		if Input.is_action_just_pressed("accept"):
			if screen_list[1].visible: _button_reset()
			elif screen_list[2].visible: _button_start()
		if Input.is_action_just_pressed("back"): _button_quit()

func toggle_screen(ind: int, toggle: bool):
	screen_list[ind].visible = toggle
	
	if screen_list[1].visible:
		button_list = screen_list[1].get_child(0).get_child(0).get_children()
	else:
		button_list = screen_list[2].get_child(0).get_child(1).get_children()
	
	load_score_text(GameController.highscore)

func load_score_text(hs: int):
	if screen_list[2].visible:
		screen_list[2].get_child(0).get_child(2).text = "[center]High\nScore\n\n%s[/center]" % str(hs)
	elif screen_list[1].visible:
		screen_list[1].get_child(0).get_child(2).text = "[center]High\nScore\n\n%s[/center]" % str(hs)

func _button_reset():
	GameController.restart_game()
	for i in screen_list:
		i.visible = false
	screen_list[0].visible = true

func _button_quit():
	GameController.save_score()
	get_tree().quit()

func _button_start():
	screen_list[0].visible = true
	screen_list[2].visible = false
	GameController.start_game()
