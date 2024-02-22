extends Node;

@onready var _health_label: Label;

var health: int = 100:
	set =_update_health_label;

func _update_health_label(new_health: int) -> void:
	if !_health_label:
		_health_label = get_node("/root/Main/CanvasLayer/UIOverlay/ResourceInformation/HealthContainer/HealthLabel");

	health = new_health;
	_health_label.set_text(str(new_health));
