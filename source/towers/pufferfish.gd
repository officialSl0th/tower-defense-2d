extends Tower;
class_name Pufferfish;

func _attack() -> void:
	_rotate_tower(_path_entities_in_range[0].get_position());

	for _entity in _path_entities_in_range:
		_entity.take_damage(attack_damage);
