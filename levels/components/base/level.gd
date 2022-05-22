extends Node2D
export var palette : Image

func _ready() -> void:
	if palette.get_width() != 4:
		printerr("level.gd, ", name, " incorrectTexture: ", palette.resource_path)

func getColor(index : int = 0) -> Color:
	palette.lock()
	if index < 0 or index > 4:
		printerr("level.gd, index is incorrent: ", index)
		return palette.get_pixel(4, 0)
	else:
		return palette.get_pixel(index, 0)
