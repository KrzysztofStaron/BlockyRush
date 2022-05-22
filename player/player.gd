extends KinematicBody2D

export var gravity := 4120
export var speed := 720
export var jumpHeight := -1300

var velocity : Vector2

func _ready():
	var color : Color = get_tree().get_nodes_in_group("level")[0].getColor(3)
	$Sprite.material.set_shader_param("color", color)
	
	resetPosition()

func _process(delta):
	velocity.y += gravity * delta
	position.x += speed * delta
	
	if Input.is_action_pressed("jump") and (len($groundSensor.get_overlapping_bodies()) > 0 or len($groundSensor.get_overlapping_areas()) > 0):
		velocity.y = jumpHeight
		$AnimationTree.get("parameters/playback").travel("jump")
	
	if get_tree().get_nodes_in_group("level")[0].get_node("endPoint").position.y < position.y:
		print("walll kill")
		resetPosition()
	
	if get_tree().get_nodes_in_group("level")[0].get_node("endPoint").position.x < position.x:
		print("win")
		resetPosition()
		
	velocity.y = move_and_slide(velocity).y

func resetPosition():
	position = get_tree().get_nodes_in_group("level")[0].get_node("startPoint").position

func die(_body := Node.new()):
	print("spike kill")
	resetPosition()

func _on_area_2d_body_entered(_body):
	die()
