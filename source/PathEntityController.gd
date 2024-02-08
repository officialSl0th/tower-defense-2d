extends PathFollow2D
class_name PathEntityController

@export var move_speed: float = 0;
@export var health: int = 0;

func _process(delta: float) -> void:
	# despawn when end reached
	if get_progress_ratio() == 1:
		queue_free()

	# update position
	set_progress(get_progress() + move_speed * delta);

func take_damage(attack_damage: int) -> void:
	health -= attack_damage;

	if health == 0:
		queue_free();
