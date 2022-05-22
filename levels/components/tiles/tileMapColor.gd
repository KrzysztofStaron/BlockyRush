extends TileMap

export var index : int = 0

func _ready():
	var color : Color = get_tree().get_nodes_in_group("level")[0].getColor(index)
	material.set_shader_param("color", color)