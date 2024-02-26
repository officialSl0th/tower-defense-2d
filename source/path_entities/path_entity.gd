extends PathFollow2D;
class_name PathEntity;

signal removed(entity: PathEntity);

var resource: PathEntityResource;

@onready var _health_bar: QuadMesh = $HealthContainer/HealthBar.get_mesh();
@onready var _max_health_bar_size: Vector2 = _health_bar.size;

var path: Path2D;
var curve: Curve2D;

var _move_speed: float;
var _total_health: int;
var _current_health: int;

func _ready() -> void:
	_move_speed = resource.move_speed;
	_total_health = resource.total_health;
	_current_health = _total_health;

	path = get_parent();
	curve = path.get_curve();


func _physics_process(delta: float) -> void:
	if get_progress_ratio() == 1:
		Health.health -= _total_health;
		_remove();

	if Health.health == 0:
		set_physics_process(false);

	set_progress(get_progress() + _move_speed * delta);


func take_damage(attack_damage: int) -> void:
	_current_health -= attack_damage
	_health_bar.size = Vector2(_current_health / float(_total_health) * _max_health_bar_size[0], 1);

	if _current_health <= 0:
		Money.money += resource.money;
		_remove();


func get_future_position(time: float) -> Vector2:
	var _progress = get_progress();
	var _new_progress = _progress + _move_speed * time;

	var _dummy = PathFollow2D.new();
	path.add_child(_dummy);
	_dummy.set_progress(_new_progress);
	var _new_position = _dummy.get_position();
	_dummy.queue_free();

	return _new_position;


func _remove() -> void:
	removed.emit(self);
	queue_free();
