extends Interactable

export var light : NodePath
export var on_by_default = true
export var Energy_when_on = 1
export var Energy_when_off = 0

onready var light_node= get_node(light)
onready var on = on_by_default

func _ready():
	set_light_energy()

func get_interaction_text():
	return "Switch Light OFF" if on else "Switch Light ON"
	#kalo on dia nongol bacaan (switch light off)
	#nah kalo else ini maksudnya selain ON(alias OFF), bakal jadi (Switch Light ON)
	
func interact():
	on = not on
	set_light_energy()
	
func set_light_energy():
	light_node .set_param(Light.PARAM_ENERGY, Energy_when_on if on else Energy_when_off)
