extends PathFollow2D
class_name PathEntity

@export var move_speed: float = 0;
@export var total_health: int = 0;

@onready var _current_health: int = total_health;
@onready var _health_bar: QuadMesh = $HealthContainer/HealthBar.get_mesh();

@onready var _max_health_bar_size: Vector2 = _health_bar.size;

func _process(delta: float) -> void:
	if get_progress_ratio() == 1:
		Health.health -= total_health;
		queue_free()

	set_progress(get_progress() + move_speed * delta);

func take_damage(attack_damage: int) -> void:
	_current_health -= attack_damage
	_health_bar.size = Vector2(_current_health / float(total_health) * _max_health_bar_size[0], 1);

	if _current_health == 0:
		queue_free();
