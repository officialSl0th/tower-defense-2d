extends Node
class_name WaveController

@export var waves: Waves;
@export var paths: Array[Path2D];
@export var entity_scene: PackedScene;

@onready var _wave_timer: Timer = Timer.new();
@onready var _entity_group_timer: Timer = Timer.new();
@onready var _entity_timer: Timer = Timer.new();

var _current_wave_index: int = 0;
var _current_entity_group_index: int = 0;
var _current_entity_index: int = 0;

var _current_wave: Wave;
var _current_entity_group: EntityGroup;
var _entity_list: Array[PathEntity];

func _ready() -> void:
	_wave_timer.set_wait_time(waves.time_before_waves);
	_wave_timer.set_one_shot(true);
	_wave_timer.timeout.connect(_start_wave);
	add_child(_wave_timer);

	_entity_group_timer.set_one_shot(true);
	_entity_group_timer.timeout.connect(_start_entity_group);
	add_child(_entity_group_timer);

	_entity_timer.timeout.connect(_spawn_entity);
	add_child(_entity_timer);

	_wave_timer.start();

func _start_wave() -> void:
	print("Wave " + str(_current_wave_index) + " started");

	_current_wave = waves.waves[_current_wave_index];

	_entity_group_timer.set_wait_time(_current_wave.time_between_groups);
	_current_entity_group_index = 0;
	_start_entity_group();

func _end_wave() -> void:
	print("Wave " + str(_current_wave_index) + " ended");

	_current_wave_index += 1;

	if _current_wave_index < len(waves.waves):
		_wave_timer.set_wait_time(waves.time_between_waves);
		_wave_timer.start();

func _start_entity_group() -> void:
	print("Entity group " + str(_current_entity_group_index) + " started");

	_current_entity_group = _current_wave.entity_groups[_current_entity_group_index];
	_entity_timer.set_wait_time(_current_entity_group.time_between_entities);
	_entity_timer.start();
	_spawn_entity();

func _end_entity_group() -> void:
	print("Entity group " + str(_current_entity_group_index) + " ended");

	_current_entity_group_index += 1;
	_current_entity_index = 0;
	_entity_timer.stop();

	if _current_entity_group_index < len(_current_wave.entity_groups):
		_entity_group_timer.start();

func _spawn_entity() -> void:
	if _current_entity_index == _current_entity_group.amount_of_entities:
		_end_entity_group();
		return;

	var _entity: PathEntity = entity_scene.instantiate();
	_entity.resource = _current_entity_group.entity_resource;
	_entity.removed.connect(_entity_removed);

	var _path_curve: Curve2D = paths[_current_entity_group.path_id].get_curve();
	_entity.set_position(_path_curve.get_point_position(0));

	paths[_current_entity_group.path_id].add_child(_entity);
	_current_entity_index += 1;
	_entity_list.append(_entity);

	print("Spawned entity " + str(_current_entity_index));

func _entity_removed(entity: PathEntity) -> void:
	_entity_list.erase(entity);

	if !_entity_list:
		_end_wave();
