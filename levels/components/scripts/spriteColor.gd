extends Sprite

var speed := 1.0
export var index : int = 0

var currentColor := Color()
var targetColor : Color

func _ready():
	currentColor = targetColor
	get_tree().get_nodes_in_group("level")[0].connect("paletteChanged", self, "updateColor")

func _process(delta: float) -> void:
	currentColor.r = move_toward(currentColor.r, targetColor.r, speed * delta)
	currentColor.g = move_toward(currentColor.g, targetColor.g, speed * delta)
	currentColor.b = move_toward(currentColor.b, targetColor.b, speed * delta)
	
	self_modulate = currentColor
	
func updateColor(_speed := 1.0):
	speed = _speed
	targetColor = get_tree().get_nodes_in_group("level")[0].getColor(index)
	if currentColor == Color():
		print("no color!")
		currentColor = targetColor
