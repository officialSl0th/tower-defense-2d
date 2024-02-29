extends Tower;
class_name CoralReef;

@export var projectile: PackedScene;

func _attack() -> void:
	var _old_target = _path_entities_in_range[0].get_position();
	var _dist_to_target = _old_target.distance_to(_position);
	var _time_to_hit = _dist_to_target / projectile_speed;
	var _new_target = _path_entities_in_range[0].get_future_position(_time_to_hit);

	var _direction: Vector2 = (_new_target - _position).normalized();
	call_deferred("_spawn_projectile", _direction);


func _spawn_projectile(direction: Vector2) -> void:
	var _projectile: Projectile = projectile.instantiate();
	_projectile.initialize(projectile_speed, max_projectile_range, attack_damage);
	_projectile.set_projectile_rotation(direction);
	add_child(_projectile);
