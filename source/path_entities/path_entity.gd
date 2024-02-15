extends PathFollow2D;
class_name PathEntity;

signal removed(entity: PathEntity);

var resource: PathEntityResource;

@onready var _health_bar: QuadMesh = $HealthContainer/HealthBar.get_mesh();
@onready var _max_health_bar_size: Vector2 = _health_bar.size;

var _move_speed: float;
var _total_health: int;
var _current_health: int;

func _ready() -> void:
	_move_speed = resource.move_speed;
	_total_health = resource.total_health;
	_current_health = _total_health;


func _process(delta: float) -> void:
	if get_progress_ratio() == 1:
		Health.health -= _total_health;
		removed.emit(self);
		queue_free()

	set_progress(get_progress() + _move_speed * delta);


func take_damage(attack_damage: int) -> void:
	_current_health -= attack_damage
	_health_bar.size = Vector2(_current_health / float(_total_health) * _max_health_bar_size[0], 1);

	if _current_health == 0:
		removed.emit(self);
		queue_free();
