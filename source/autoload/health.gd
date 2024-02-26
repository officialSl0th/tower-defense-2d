extends Node;

@onready var _health_label: Label;

var health: int = 100:
	set =_update_health_label;

func _update_health_label(new_health: int) -> void:
	if !_health_label:
		_health_label = get_node("/root/Main/CanvasLayer/UIOverlay/ResourceInformation/HealthContainer/HealthLabel");

	health = new_health;

	if new_health <= 0:
		health = 0;
		get_node("/root/Main/CanvasLayer").add_child(load("res://scenes/game_over_overlay.tscn").instantiate());

	_health_label.set_text(str(health));
