extends Tower;
class_name ShortRange;

func _attack() -> void:
	_path_entities_in_range[0].take_damage(attack_damage);
