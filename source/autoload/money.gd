extends Node;

@onready var _money_label: Label = get_node("/root/Main/CanvasLayer/UIOverlay/ResourceInformation/MoneyContainer/MoneyLabel");

var money: int = 500:
	set =_update_money_label;

func _update_money_label(new_money: int) -> void:
	money = new_money;
	_money_label.set_text(str(new_money));
