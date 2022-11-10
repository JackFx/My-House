extends Interactable
#coding ini dari codewithtom
export var light : NodePath
export var light2 : NodePath
export var light3 : NodePath
export var light4 : NodePath
export var on_by_default = true
export var Energy_when_on = 1
export var Energy_when_off = 0

onready var light_node= get_node(light)
onready var light_node2= get_node(light2)
onready var light_node3= get_node(light3)
onready var light_node4= get_node(light4)
onready var on = on_by_default

func _ready():
	set_light_energy()
	set_light_energy2()
	set_light_energy3()
	set_light_energy4()

func get_interaction_text():
	return "Switch Light OFF" if on else "Switch Light ON"
	#kalo on dia nongol bacaan (switch light off)
	#nah kalo else ini maksudnya selain ON(alias OFF), bakal jadi (Switch Light ON)
	
func interact():
	on = not on
	set_light_energy()
	set_light_energy2()
	set_light_energy3()
	set_light_energy4()
	
func set_light_energy():
	light_node.set_param(Light.PARAM_ENERGY, Energy_when_on if on else Energy_when_off)
func set_light_energy2():
	light_node2.set_param(Light.PARAM_ENERGY, Energy_when_on if on else Energy_when_off)
func set_light_energy3():
	light_node3.set_param(Light.PARAM_ENERGY, Energy_when_on if on else Energy_when_off)
func set_light_energy4():
	light_node4.set_param(Light.PARAM_ENERGY, Energy_when_on if on else Energy_when_off)
