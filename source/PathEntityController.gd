extends PathFollow2D
class_name PathEntityController

@export var move_speed: float = 0;
@export var health: int = 0;

@onready var _damage: int = health;

func _process(delta: float) -> void:
	if get_progress_ratio() == 1:
		Health.health -= _damage;
		queue_free()

	set_progress(get_progress() + move_speed * delta);

func take_damage(attack_damage: int) -> void:
	health -= attack_damage;

	if health == 0:
		queue_free();
