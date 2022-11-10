extends ColorRect

func _process(delta):
	$fpx_counter.text = str(Engine.get_frames_per_second())
