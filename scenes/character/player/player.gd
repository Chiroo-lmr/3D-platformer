extends CharacterBody3D

var xform : Transform3D
var speed = 1
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const SNEAK_SPEED = 3
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.005

const CHARACTER_FREQ = 2.0
const CHARACTER_AMP = 0.08
var t_CHARACTER = 0.0 

const BASE_FOV = 75.0
const FOV_CHANGE = 0.1
var gravity = 13
@onready var neck = $Neck
@onready var camera = $Neck/POV

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(90))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY 
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
	#avoir la caméra qui bouge ( jsp si je le met)
	#if is_on_floor() and input_dir != Vector2(0, 0) or is_on_floor_only():
	#	align_with_floor($RayCast3D.get_collision_normal())
	#	global_transform = global_transform.interpolate_with(xform, 0.3)
	#elif not is_on_floor():
	#	align_with_floor(Vector3.UP )
	#	global_transform = global_transform.interpolate_with(xform, 0.3)
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
		
	t_CHARACTER += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _head_CHARACTER(t_CHARACTER)
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	if is_on_floor():
		camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	move_and_slide()

func _head_CHARACTER(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * CHARACTER_FREQ) * CHARACTER_AMP
	pos.x = sin(time * CHARACTER_FREQ / 2 ) * CHARACTER_AMP
	return pos

func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()
