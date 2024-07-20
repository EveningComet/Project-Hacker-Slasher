## Simulates an effect.
class_name BulletHole extends Decal

@export var max_lifetime: float = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(max_lifetime, false, true).timeout
	queue_free()
