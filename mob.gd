extends CharacterBody3D
class_name Mob

@export var move_speed: float = 3.0
@export var spawn_distance: float = 20.0

var player: CharacterBody3D = null
var camera: Camera3D = null

func _ready():
	if player == null:
		player = get_parent().get_node_or_null("Player")
	camera = get_viewport().get_camera_3d()

	if not player or not camera:
		push_error("Player or Camera3D not found.")
		return

	_spawn_outside_view()

func _physics_process(_delta):
	if not player:
		return
	var direction = (player.global_transform.origin - global_transform.origin).normalized()
	velocity = direction * move_speed
	move_and_slide()

func _spawn_outside_view():
	var cam_transform = camera.global_transform
	var cam_forward = -cam_transform.basis.z.normalized()
	var cam_right = cam_transform.basis.x.normalized()
	var cam_up = cam_transform.basis.y.normalized()

	var rand = randi() % 4
	var offset_dir: Vector3
	match rand:
		0: offset_dir = cam_right
		1: offset_dir = -cam_right
		2: offset_dir = cam_up
		3: offset_dir = -cam_up

	var spawn_pos = cam_transform.origin + (cam_forward * 10.0) + (offset_dir * spawn_distance)
	global_transform.origin = spawn_pos
