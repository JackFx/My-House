extends Spatial

onready var sound_cricket = $Cricket/C1
onready var sound_cricket2 = $Cricket/C2
onready var sound_cricket3 = $Cricket/C3




func _ready():
	sound_cricket.play()
	sound_cricket2.play()
	sound_cricket3.play()
