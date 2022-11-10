extends RayCast

# ini code Dari channel GameDevBoi
var interactables = []
#punya raycast
var current_collider

onready var sound_cetekan = $CetekanSound
onready var interaction_label = get_node("/root/World/UI/InteractionLabel")
onready var interaction_label_door = get_node("/root/World/UI/InteractionLabelDoor")

#punya raycast
func _ready():
	set_inteeraction_text("")

func _process(_delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			set_inteeraction_text(collider.get_interaction_text())
			current_collider = collider
			
		if Input.is_action_just_pressed("Interact"):
			sound_cetekan.play()
			collider.interact()
			set_inteeraction_text(collider.get_interaction_text())

	elif current_collider: 
		current_collider = null
		set_inteeraction_text("")
	
	elif not interactables.empty() and interactables.front().has_method("interact"):
		if Input.is_action_just_pressed("Interact"):
			interactables.front().interact()
				
func _on_Area_body_entered(body):
	if body.has_method("interact"):
		interactables.append(body)
func _on_Area_body_exited(body):
	if body.has_method("interact"): 
		interactables.clear()

			
func set_inteeraction_text(text):
	if !text:
		interaction_label.set_text("")
		interaction_label.set_visible(false)

	else:
		var interact_key = OS.get_scancode_string(InputMap.get_action_list("Interact")[0].scancode)
		interaction_label.set_text("Press %s  to %s " % [interact_key, text])
		interaction_label.set_visible(true)


