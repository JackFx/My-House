extends StaticBody

export var closed_angle = Vector3(0,0,0)
export var open_angle = Vector3(0,0,0)
onready var tween = $Tween

onready var door_sound = $DoorSound

var in_animation = false
var open = false


func interact():
	if in_animation:
		return
	else:
		open_and_close()
		
		
func open_and_close():
	
	#not open mean close
	if not open and not in_animation:
		in_animation = true
		tween.interpolate_property(self, "rotation_degrees", closed_angle, open_angle, 0.5 , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		door_sound.play()

	#case if open
	elif open and not in_animation:
		in_animation = true
		tween.interpolate_property(self, "rotation_degrees", open_angle, closed_angle, 0.5 , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		door_sound.play()
				
	tween.start()


func _on_Tween_tween_all_completed():
	#open artinya tidak open dan sebaliknya tidak open artinya open
	open = !open
	in_animation = false
