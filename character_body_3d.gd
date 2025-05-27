extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GUN_SMOOTH_SPEED = 4
const GUN_DISTANCE = 0.5
const BULLET_SPEED = 50.0

@onready var gun_mount: Node3D = $GunMount
@onready var bullet_scene: PackedScene = preload("res://bullet.tscn")

var gun_target_position: Vector3

func _ready():
	gun_target_position = gun_mount.position

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement input
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if move_dir != Vector3.ZERO:
		velocity.x = move_dir.x * SPEED
		velocity.z = move_dir.z * SPEED

		var world_target = global_transform.origin + move_dir * GUN_DISTANCE
		world_target.y = global_transform.origin.y
		gun_target_position = to_local(world_target)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	# Gun movement and rotation
	gun_mount.position = gun_mount.position.lerp(gun_target_position, GUN_SMOOTH_SPEED * delta)
	var flat_pos = Vector3(global_transform.origin.x, gun_mount.global_transform.origin.y, global_transform.origin.z)
	gun_mount.look_at(flat_pos, Vector3.UP)

	# Fire bullet
	if Input.is_action_just_pressed("shoot"):
		fire_bullet()

func fire_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.global_transform = gun_mount.global_transform
	get_tree().current_scene.add_child(bullet)
	bullet.set_velocity(-gun_mount.global_transform.basis.z * BULLET_SPEED)
