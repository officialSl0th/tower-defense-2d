extends Node2D;
class_name Tower;

@export var attack_range: float;
@export var attack_damage: int;
@export var attack_speed: float;
@export var projectile_speed: float;
@export var max_projectile_range: float;
@export var cost: int;

@onready var _attack_range_collision_shape: CollisionShape2D = $RangeArea/CollisionShape2D;
@onready var _attack_speed_timer: Timer = $AttackSpeedTimer;
@onready var _tower_area: Area2D = $TowerArea;
@onready var _sprite: Sprite2D = $Sprite2D;

var _position: Vector2;
var _path_entities_in_range: Array[PathEntity];
var _attack_range_color: Color = Color(0, 0, 0, .3);
var _place_mode: bool = true;
var can_place: bool = true;

func _ready() -> void:
	_attack_range_collision_shape.shape.radius = attack_range;
	_attack_speed_timer.set_wait_time(attack_speed);


func _process(_delta: float) -> void:
	if _tower_area.has_overlapping_areas() || Money.money < cost:
		can_place = false;
		_attack_range_color = Color(1, 0, 0, .3);
		_sprite.material.set("shader_parameter/can_place", can_place);
		queue_redraw();

	else:
		can_place = true;
		_attack_range_color = Color(0, 0, 0, .3);
		_sprite.material.set("shader_parameter/can_place", can_place)
		queue_redraw();


func _draw() -> void:
	draw_circle(Vector2(0, 0), attack_range * 2, _attack_range_color);


func _attack() -> void:
	pass;


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
	if can_place:
		_place_mode = false;
		_position = get_position();
		set_process(false);

		Money.money -= cost;

		if _path_entities_in_range:
			_attack()
			_attack_speed_timer.start();

		return true;

	return false;


func cancel_tower_placement() -> void:
	queue_free();


func _rotate_tower(target: Vector2) -> void:
	set_rotation(target.angle_to_point(_position) - PI / 2);
