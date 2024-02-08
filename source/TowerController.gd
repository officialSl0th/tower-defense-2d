extends Node2D
class_name TowerController

@export var attack_range: float = 0;
@export var attack_damage: float = 0;
@export var attack_speed: float = 0;

@onready var _attack_range_collision_shape: CollisionShape2D = $RangeArea/CollisionShape2D;
@onready var _attack_speed_timer: Timer = $AttackSpeedTimer;

var _path_entities_in_range: Array = [];
var _attack_range_color: Color = Color(0, 0, 0, .3);

func _ready() -> void:
	_attack_range_collision_shape.shape.radius = attack_range;
	_attack_speed_timer.set_wait_time(attack_speed);

func _draw() -> void:
	draw_circle(Vector2(0, 0), attack_range * 2, _attack_range_color);

func _attack() -> void:
	_path_entities_in_range[0].take_damage(attack_damage);

func _path_entity_entered(entity: Area2D) -> void:
	_path_entities_in_range.append(entity.get_parent());

	if _attack_speed_timer.is_stopped():
		_attack();
		_attack_speed_timer.start();

func _path_entity_exited(entity: Area2D) -> void:
	_path_entities_in_range.erase(entity.get_parent());

	if _path_entities_in_range.is_empty():
		_attack_speed_timer.stop();
