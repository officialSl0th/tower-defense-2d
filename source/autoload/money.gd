extends Node;

var _money_label: Label;

var money: int = 300:
	set =_update_money_label;

func _update_money_label(new_money: int) -> void:
	if !_money_label:
		_money_label = get_node("/root/Main/CanvasLayer/UIOverlay/ResourceInformation/MoneyContainer/MoneyLabel");

	money = new_money;
	_money_label.set_text(str(new_money));
