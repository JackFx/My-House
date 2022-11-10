extends KinematicBody

#ini kode Control dari channel codewithtom and St
export var default_speed = 6
export var run_speed = 1.6
export var run_slow = 2.5

export var acceleration = 6
export var gravity = 0.90
export var jump_power = 25
export var mouse_sensi = 0.1

const sway = 11
onready var head = $Head


onready var camera = $Head/Camera
onready var gun_camera = $Head/Camera/Hand/ViewportContainer/Viewport/GunCam
onready var flashlight = $Head/Camera/Hand/Flashlight

onready var ground_check = $GroundCheck

onready var handloc = $Head/Camera/Handloc
onready var hand = $Head/Camera/Hand

onready var anim_player = $Head/Camera/AnimationPlayer
onready var anim_player1 = $Head/Camera/zoom_camera
onready var anim_run = $Head/Camera/run
onready var anim_head = $Head_Anim

onready var flashlight_sound = $Head/Camera/Hand/Flashlight/FlashLightSound
onready var run_sound = $Head/run__audio

onready var cricket_sound = $Cricket/sound_cricket

var speed = default_speed
var velocity = Vector3()
var camera_x_rotation = 0
var full_contact = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hand.set_as_toplevel(true)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(event.relative.x * -mouse_sensi))
		
		var x_delta = event.relative.y * mouse_sensi
		if camera_x_rotation + x_delta > -90 and  camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta
	if event is InputEventKey:
		if event.scancode == KEY_F and event.pressed:
			flashlight.visible = not flashlight.visible
			flashlight_sound.play()
			
func _process(delta):
	
	gun_camera.global_transform = camera.global_transform
	hand.global_transform.origin = handloc.global_transform.origin
	hand.rotation.y = lerp_angle(hand.rotation.y, head.rotation.y, sway * delta)
	hand.rotation.x = lerp_angle(hand.rotation.x, camera.rotation.x, sway * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_just_pressed("ui_accept"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	var head_basis =  head.get_global_transform().basis
	
	var direction = Vector3()
	if Input.is_action_pressed("move_up"):
		anim_player.play("head_bob")
		direction -= head_basis.z
	elif Input.is_action_pressed("move_back"):
		direction += head_basis.z
		anim_player.play("head_bob")
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
		anim_player.play("head_bob")
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
		anim_player.play("head_bob")
	
	speed = default_speed
	#if Input.is_action_just_pressed("move_sprint"):
	#1	speed = run_speed * default_speed

	if Input.is_action_pressed("move_slow"):
		speed = default_speed - run_slow
	
	if Input.is_action_pressed("move_jump") and is_on_floor():
		##and is_on_floor()
		velocity.y += jump_power
		
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	var gravity_resistance = get_floor_normal() if is_on_floor() else Vector3.UP
	velocity -= gravity_resistance * gravity
	velocity = move_and_slide(velocity, Vector3.UP)	
	
	if Input.is_action_just_pressed("right_click"):
		anim_player1.play("zoom")
	elif Input.is_action_just_released("right_click"):
		anim_player1.play("zoom_out")
