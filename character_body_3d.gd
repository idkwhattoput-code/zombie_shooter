extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GUN_SMOOTH_SPEED = 4
const GUN_DISTANCE = 0.4

@onready var gun_mount: Node3D = $GunMount

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

	# Input direction
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		# Target pos on XZ plane
		var world_target = global_transform.origin + direction * GUN_DISTANCE
		world_target.y = global_transform.origin.y  # keep flat
		gun_target_position = to_local(world_target)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	# Smooth gun orbit + rotation
	gun_mount.position = gun_mount.position.lerp(gun_target_position, GUN_SMOOTH_SPEED * delta)
	var flat_player_pos = Vector3(global_transform.origin.x, gun_mount.global_transform.origin.y, global_transform.origin.z)
	gun_mount.look_at(flat_player_pos, Vector3.UP)
