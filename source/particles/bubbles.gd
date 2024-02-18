extends GPUParticles2D;
class_name Bubbles;

@export var time_before_first: float;
@export var time_between: float;

@onready var _timer: Timer = $Timer;

var _first: bool = true;

func _ready() -> void:
	_timer.set_wait_time(time_before_first);
	_timer.start();


func _on_timer_timeout() -> void:
	if _first:
		_timer.set_wait_time(time_between);

	restart();


func _on_finished() -> void:
	_timer.start();
