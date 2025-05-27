extends Node3D

var velocity: Vector3 = Vector3.ZERO

func set_velocity(v: Vector3):
	velocity = v

func _physics_process(delta: float) -> void:
	translate(velocity * delta)
