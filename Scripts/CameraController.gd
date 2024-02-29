extends Camera2D

func _ready():
	position.y = -get_viewport_rect().size.y / 2
