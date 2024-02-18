extends Node
class_name Shock;

var duration_of_shock: float;
var time_between_shocks: float;
var shock_damage: int;

@onready var _path_entity: PathEntity = get_parent();

func _ready() -> void:
	var _duration_timer = Timer.new();
	_duration_timer.set_wait_time(duration_of_shock);
	_duration_timer.timeout.connect(_duration_timer_timeout);
	add_child(_duration_timer);

	var _shock_timer = Timer.new();
	_shock_timer.set_wait_time(time_between_shocks);
	_shock_timer.timeout.connect(_shock_timer_timeout);
	add_child(_shock_timer);

	_duration_timer.start();
	_shock_timer.start();


func _duration_timer_timeout() -> void:
	queue_free();


func _shock_timer_timeout() -> void:
	_path_entity.take_damage(shock_damage);
