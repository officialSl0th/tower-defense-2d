extends Node

func _play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn");


func _options_button_pressed() -> void:
	pass # Replace with function body.


func _quit_button_pressed() -> void:
	get_tree().quit();
