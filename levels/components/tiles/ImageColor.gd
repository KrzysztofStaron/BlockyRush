extends TextureRect

export var index : int = 0

func _ready():
	var color : Color = get_tree().get_nodes_in_group("level")[0].getColor(index)
	self_modulate = color
