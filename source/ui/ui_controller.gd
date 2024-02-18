extends Control;
class_name UIController;

@export var towers: Array[PackedScene];

@onready var _tower_parent: Node2D = $"../../Towers";
@onready var _viewport_size: Vector2 = get_viewport_rect().size;

var _tower_to_place: Tower;

func _tower_select_button_pressed(id: int) -> void:
	if _tower_to_place:
		_tower_to_place.queue_free();

	_tower_to_place = towers[id].instantiate();
	_tower_to_place.set_position(get_viewport().get_mouse_position());
	_tower_parent.add_child(_tower_to_place);


func _input(event: InputEvent) -> void:
	if !_tower_to_place:
		return;

	if event is InputEventMouseMotion:
		var _mouse_position = get_viewport().get_mouse_position();
		if _mouse_position[0] < _viewport_size[0] && _mouse_position[1] < _viewport_size[1] && _mouse_position[0] > 0 && _mouse_position[1] > 0:
			_tower_to_place.set_position(get_viewport().get_mouse_position());

	elif event is InputEventMouseButton:
		if event.button_index == 1:
			if _tower_to_place.confirm_tower_placement():
				_tower_to_place = null;

		elif event.button_index == 2:
			_tower_to_place.cancel_tower_placement();
			_tower_to_place = null;
