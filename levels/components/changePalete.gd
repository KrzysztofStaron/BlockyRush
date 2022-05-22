extends Area2D

export var palette : Image

func _on_changePalete_body_exited(body: Node) -> void:
	get_tree().get_nodes_in_group("level")[0].changePalette(palette)
