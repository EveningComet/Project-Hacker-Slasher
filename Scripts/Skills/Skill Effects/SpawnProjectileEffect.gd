## For skills that need to spawn a projectile.
class_name SpawnProjectileEffect extends SkillEffect

@export var num_to_spawn:      int = 1
@export var projectile_prefab: PackedScene

func execute(activator, targets) -> void:
	for i in num_to_spawn:
		pass
