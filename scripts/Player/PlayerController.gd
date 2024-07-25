class_name PlayerController
extends Node

var INPUT_DIRECTION: Vector2;
var movementComponent :SideScrollingMovement;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	movementComponent = $SideScrollingMovement

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	INPUT_DIRECTION = Input.get_vector("Left", "Right", "Up", "Down")
	movementComponent.move(INPUT_DIRECTION)
	if(Input.is_action_just_pressed("Jump") or Input.is_action_just_pressed("Up")):
		movementComponent.jump()
 
