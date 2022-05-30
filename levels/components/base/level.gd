extends Node2D

export var defaultPalette : Image
export var currentPalette : Image

signal paletteChanged(speed)

func _ready() -> void:
	changePalette()

func getColor(index : int = 0) -> Color:
	currentPalette.lock()
	if index < 0 or index > 4:
		printerr("level.gd, index is incorrent: ", index)
		return currentPalette.get_pixel(4, 0)
	else:
		return currentPalette.get_pixel(index, 0)

func changePalette(newPalette: Image = defaultPalette, speed := 1.0):
	currentPalette = newPalette
	emit_signal("paletteChanged", speed)
