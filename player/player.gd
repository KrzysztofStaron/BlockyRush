extends KinematicBody2D

export var gravity := 4120
export var speed := 720
export var jumpHeight := -1300

var colorSpeed := 1.0
var currentColor := Color()
var targetColor : Color

var velocity : Vector2

func _ready():
	get_tree().get_nodes_in_group("level")[0].connect("paletteChanged", self, "updateColor")
	resetPosition()

func _process(delta):
	currentColor.r = move_toward(currentColor.r, targetColor.r, colorSpeed * delta)
	currentColor.g = move_toward(currentColor.g, targetColor.g, colorSpeed * delta)
	currentColor.b = move_toward(currentColor.b, targetColor.b, colorSpeed * delta)
	
	$Sprite.material.set_shader_param("color", currentColor)
	
	velocity.y += gravity * delta
	position.x += speed * delta
	
	if Input.is_action_pressed("jump") and (len($groundSensor.get_overlapping_bodies()) > 0 or len($groundSensor.get_overlapping_areas()) > 0):
		velocity.y = jumpHeight
		$AnimationTree.get("parameters/playback").travel("jump")
	
	if get_tree().get_nodes_in_group("level")[0].get_node("endPoint").position.y < position.y:
		#print("fall kill")
		resetPosition()
	
	if get_tree().get_nodes_in_group("level")[0].get_node("endPoint").position.x < position.x:
		#print("win")
		resetPosition()
		
	velocity.y = move_and_slide(velocity).y

func resetPosition():
	position = get_tree().get_nodes_in_group("level")[0].get_node("startPoint").position
	get_tree().get_nodes_in_group("level")[0].changePalette()

func die(_body := Node.new()):
	#print("spike or wall kill")
	resetPosition()

func _on_area_2d_body_entered(_body):
	die()

func updateColor(_speed : float):
	colorSpeed = _speed
	targetColor = get_tree().get_nodes_in_group("level")[0].getColor(3)
	if currentColor == Color():
		print("no color!")
		currentColor = targetColor
