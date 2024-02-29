extends Tower;
class_name ShortRange;

func _attack() -> void:
	_rotate_tower(_path_entities_in_range[0].get_position());
	_path_entities_in_range[0].take_damage(attack_damage);
