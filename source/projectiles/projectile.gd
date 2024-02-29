extends Node2D;
class_name Projectile;

var _direction: Vector2;
var _speed: float;
var _max_travel_distance: float;
var _damage: int;

@onready var _start_position: Vector2 = get_position();

func _process(delta) -> void:
	var _position: Vector2 = get_position();
	set_position(_position + _direction * _speed * delta);

	var _direction_raw: Vector2 = get_position() - _start_position;
	if sqrt(_direction_raw[0] * _direction_raw[0] + _direction_raw[1] * _direction_raw[1]) > _max_travel_distance:
		queue_free();


func initialize(speed: float, max_travel_distance: float, damage: int) -> void:
	_direction = Vector2.from_angle(get_rotation());
	var _x = _direction[0];
	_direction[0] = _direction[1];
	_direction[1] = -_x;

	_speed = speed;
	_max_travel_distance = max_travel_distance;
	_damage = damage;


func set_projectile_rotation(direction: Vector2) -> void:
	_direction = direction;
	set_rotation(get_position().angle_to_point(direction));


func _hit(body: Area2D) -> void:
	var _parent: Node2D = body.get_parent();

	if _parent is PathEntity:
		_parent.take_damage(_damage);
		queue_free();
