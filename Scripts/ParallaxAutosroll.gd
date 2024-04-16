extends ParallaxBackground

var scrolling_speed: float = 50

func _process(delta):
	scroll_base_offset.x += scrolling_speed * delta
