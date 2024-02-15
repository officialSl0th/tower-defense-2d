extends Node;

@onready var _health_label: Label = get_node("/root/Main/CanvasLayer/UIOverlay/HealthLabel");

var health: int = 100:
	set =_update_health_label;

func _update_health_label(new_health: int) -> void:
	health = new_health;
	_health_label.set_text(str(new_health));
