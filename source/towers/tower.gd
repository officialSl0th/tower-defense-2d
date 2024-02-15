extends Node2D;
class_name Tower;

@export var resource: TowerResource;

@onready var _attack_range_collision_shape: CollisionShape2D = $RangeArea/CollisionShape2D;
@onready var _attack_speed_timer: Timer = $AttackSpeedTimer;
@onready var _projectile_scene: PackedScene = preload("res://scenes/projectile.tscn");

var _position: Vector2;
var _attack_range: float;
var _attack_damage: float;
var _attack_speed: float;
var _projectile_speed: float;
var _max_projectile_range: float;

var _path_entities_in_range: Array[PathEntity];
var _attack_range_color: Color = Color(0, 0, 0, .3);
var _place_mode: bool = true;

func _ready() -> void:
	_attack_range = resource.attack_range;
	_attack_damage = resource.attack_damage;
	_attack_speed = resource.attack_speed;
	_projectile_speed = resource.projectile_speed;
	_max_projectile_range = resource.max_projectile_range;

	_attack_range_collision_shape.shape.radius = _attack_range;
	_attack_speed_timer.set_wait_time(_attack_speed);


func _draw() -> void:
	draw_circle(Vector2(0, 0), _attack_range * 2, _attack_range_color);


func _attack() -> void:
	var _direction: Vector2 = (_path_entities_in_range[0].get_position() - _position).normalized();
	var _projectile: Projectile = _projectile_scene.instantiate();
	_projectile.initialize(_direction, _projectile_speed, _max_projectile_range, _attack_damage);
	add_child(_projectile);


func _path_entity_entered(entity: Area2D) -> void:
	var _parent: Node2D = entity.get_parent();

	if _parent is PathEntity:
		_path_entities_in_range.append(_parent);

		if _attack_speed_timer.is_stopped() && !_place_mode:
			_attack();
			_attack_speed_timer.start();


func _path_entity_exited(entity: Area2D) -> void:
	var _parent = entity.get_parent();

	if _parent is PathEntity:
		_path_entities_in_range.erase(entity.get_parent());

		if _path_entities_in_range.is_empty():
			_attack_speed_timer.stop();


func confirm_tower_placement() -> bool:
	if _check_if_can_place():
		_place_mode = false;
		_position = get_position();

		Money.money -= resource.cost;

		if _path_entities_in_range:
			_attack()
			_attack_speed_timer.start();

		return true;

	return false;


func cancel_tower_placement() -> void:
	queue_free();


func _check_if_can_place() -> bool:
	if Money.money < resource.cost:
		return false;

	return true;
