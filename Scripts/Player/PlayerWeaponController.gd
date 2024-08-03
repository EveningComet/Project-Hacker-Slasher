## Handles attacking for a player's current active weapon.
class_name PlayerWeaponController extends Node

## The player's camera is needed to help with aiming.
@export var camera_controller: CameraController

# TODO: Make this system take into account weapon data.
# Might have to create a weapon instance object.
@export var current_weapon: Weapon

## Reference to keep track of weapon changes.
@export var player_equipment: PlayerEquipmentInventory

## Stores where the player is aiming.
var aim_dir: Vector3 = Vector3.ZERO
var cam_ray: RayCast3D

var prng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	cam_ray = camera_controller.aim_cast

func _physics_process(delta: float) -> void:
	# Handle the weapon's cooldown
	current_weapon.tick(delta)
	if Input.is_action_pressed("primary_attack") and current_weapon.curr_cooldown >= current_weapon.weapon_data.action_rate:
		current_weapon.reset_attack_cooldown()
		
		var original_rot = camera_controller.aim_cast.rotation
		match current_weapon.weapon_data.weapon_attack_type:
			"Hitscan":
				
				for i in current_weapon.weapon_data.num_shots:
					set_spread()
					if cam_ray.is_colliding() == true:
						
						var camera_col_point = cam_ray.get_collision_point()
						
						# Make the weapon's hit scan look at the point for more accuracy
						current_weapon.fire_point.look_at(camera_col_point, Vector3.UP)
						current_weapon.fire_cast.force_raycast_update()
						if current_weapon.fire_cast.is_colliding() == true:
							# Check to see if we can damage something
							var collider = current_weapon.fire_cast.get_collider()
							if collider != null and collider.has_node("Combatant"):
								var target_com: Combatant = collider.get_node("Combatant")
								target_com.take_damage(10)
								
							var col_point = current_weapon.fire_cast.get_collision_point()
							var normal    = current_weapon.fire_cast.get_collision_normal()
							var bullet_hole = current_weapon.weapon_data.bullet_hole.instantiate()
							get_tree().root.add_child(bullet_hole)
							bullet_hole.global_position = col_point
							bullet_hole.look_at(bullet_hole.global_transform.origin + normal, Vector3.UP)
							bullet_hole.rotate_object_local(Vector3(1, 0, 0), 90)
			
			"Projectile":
				for i in current_weapon.weapon_data.num_shots:
					set_spread()
					
					# Get the aim direction
					var origin:    Vector3 = current_weapon.fire_point.global_transform.origin
					var direction: Vector3 = get_aim_dir()
					var aim_dir:   Vector3 = (direction - origin).normalized()
					
					# Fire the projectile
					var projectile: Projectile = current_weapon.weapon_data.projectile_prefab.instantiate()
					get_parent().get_tree().root.add_child(projectile)
					projectile.global_position = origin
					projectile.set_direction(aim_dir)
					projectile.set_shooter(get_parent())
					projectile.look_at(origin + aim_dir, Vector3.UP)
			
			"Melee":
				pass
		
		# Reset the raycast's rotation
		cam_ray.rotation = original_rot

func set_current_weapon(swap_to: WeaponData) -> void:
	var weapon_to_swap_to: Weapon = swap_to.weapon_prefab.instantiate()
	if current_weapon != null:
		current_weapon.hide()

func set_spread() -> void:
	# Create the random spray
	var target_vector: Vector3 = Vector3.ZERO
	var spread_vector = current_weapon.weapon_data.spread
	target_vector.x = prng.randf_range(-spread_vector.x, spread_vector.x)
	target_vector.y = prng.randf_range(-spread_vector.y, spread_vector.y)
	
	cam_ray.target_position.x = target_vector.x
	cam_ray.target_position.y = target_vector.y
	cam_ray.force_raycast_update()


func get_aim_dir() -> Vector3:
	return camera_controller.aim_cast.global_transform * camera_controller.aim_cast.target_position
	
