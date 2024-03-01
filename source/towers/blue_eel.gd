extends Tower;
class_name BlueEel;

@export var projectile: PackedScene;
@export var duration_of_shock: float;
@export var time_between_shocks: float;
@export var shock_damage: int;

func _attack() -> void:
	var _old_target = _path_entities_in_range[0].get_position();
	var _dist_to_target = _old_target.distance_to(_position);
	var _time_to_hit = _dist_to_target / projectile_speed;
	var _new_target = _path_entities_in_range[0].get_future_position(_time_to_hit);

	_rotate_tower(_new_target);

	var _direction = _position.direction_to(_new_target);
	call_deferred("_spawn_projectile");


func _spawn_projectile() -> void:
	var _projectile = projectile.instantiate();
	_projectile.initialize(projectile_speed, max_projectile_range, attack_damage);
	_projectile.duration_of_shock = duration_of_shock;
	_projectile.time_between_shocks = time_between_shocks;
	_projectile.shock_damage = shock_damage;
	add_child(_projectile);
