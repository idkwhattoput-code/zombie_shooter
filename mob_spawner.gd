extends Node3D

@export var mob_scene: PackedScene
@export var spawn_interval: float = 1
@export var max_mobs: int = 30

var timer: Timer
var player: CharacterBody3D
var active_mobs: Array = []

func _ready():
	player = get_parent().get_node_or_null("Player")
	if not player:
		push_error("Player not found.")
		return

	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	active_mobs = active_mobs.filter(func(mob): return is_instance_valid(mob))

	if active_mobs.size() >= max_mobs:
		return

	if not mob_scene:
		push_error("Mob scene not assigned!")
		return

	var mob = mob_scene.instantiate()
	if mob is Mob:
		mob.player = player
		get_parent().add_child(mob)
		active_mobs.append(mob)
	else:
		push_error("Instantiated mob is not of type Mob!")
