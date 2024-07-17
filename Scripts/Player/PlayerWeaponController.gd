## Handles attacking for a player's current active weapon.
class_name PlayerWeaponController extends Node

## The player's camera is needed to help with aiming.
@export var camera_controller: CameraController

@export var current_weapon: Weapon

## Stores where the player is aiming.
var aim_dir: Vector3 = Vector3.ZERO

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Handle the weapon's cooldown
	current_weapon.tick(delta)
	set_aim_dir()
	if Input.is_action_pressed("primary_attack") and current_weapon.curr_cooldown >= current_weapon.weapon_data.action_rate:
		if OS.is_debug_build() == true:
			print("PlayerWeaponController :: %s is attacking." % [get_parent().name])
		current_weapon.reset_attack_cooldown()
		
		# Get the camera and viewport
		var cam      = camera_controller.get_camera()
		var viewport = get_viewport().get_size()
		
		var cam_ray = camera_controller.aim_cast
		if cam_ray.is_colliding() == true:
			var col_point = cam_ray.get_collision_point()
			var bullet_hole = current_weapon.weapon_data.bullet_hole.instantiate()
			get_tree().root.add_child(bullet_hole)
			bullet_hole.global_position = col_point
			bullet_hole.look_at(bullet_hole.global_transform.origin + cam_ray.get_collision_normal(), Vector3.UP)
			bullet_hole.rotate_object_local(Vector3(1, 0, 0), 90)
			await get_tree().create_timer(3.0, false, true).timeout
			bullet_hole.queue_free()
			#var from_gun = current_weapon.get_fire_point().global_position
			#var end      = current_weapon.fire_cast.target_position
			#current_weapon.fire_cast.force_raycast_update()
			#if current_weapon.fire_cast.is_colliding() == true:


func set_aim_dir() -> void:
	# Get the camera and viewport
	var cam      = camera_controller.get_camera()
	var viewport = get_viewport().get_size()
	
	# Set the direction to where the player is aiming at
	var screen_center = viewport / 2
	var ray_origin = cam.project_ray_origin(screen_center) # Get the center of the screen
	var ray_end    = ray_origin + cam.project_ray_normal(screen_center) * 1000
	aim_dir = (ray_end - ray_origin).normalized()
