extends Tower;
class_name Pufferfish;

func _attack() -> void:
	for _entity in _path_entities_in_range:
		_entity.take_damage(attack_damage);
