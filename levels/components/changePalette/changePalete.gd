extends Area2D

export var palette : Image
export var speed := 1.0

func _on_changePalete_body_exited(_body: Node) -> void:
	get_tree().get_nodes_in_group("level")[0].changePalette(palette, speed)
