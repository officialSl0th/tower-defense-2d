extends Projectile
class_name Lightning;

var duration_of_shock: float;
var time_between_shocks: float;
var shock_damage: int;

@onready var shock_script = preload("res://source/path_entities/effects/shock.gd");

func _hit(body: Area2D) -> void:
	var _parent: Node2D = body.get_parent();

	if _parent is PathEntity:
		_parent.take_damage(_damage);
		queue_free();

		if _has_schock(body.get_parent()):
			return;

		var shock_node = Node2D.new();
		shock_node.set_script(shock_script);
		shock_node.duration_of_shock = duration_of_shock;
		shock_node.time_between_shocks = time_between_shocks;
		shock_node.shock_damage = shock_damage;
		body.get_parent().add_child(shock_node);

func _has_schock(target: PathEntity) -> bool:
	for child in target.get_children():
		if child is Shock:
			return true;

	return false;
