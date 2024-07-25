class_name SideScrollingMovement
extends CharacterBody2D

var MOVEMENT_DIRECTION: Vector2;
@export var ACCELERATION: float = .4
@export var MAX_SPEED: float = 400
@export var FRICTION: float = .2
@export var GRAVITY: float = 800
@export var JUMP_VELOCITY : float = -400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if (MOVEMENT_DIRECTION.x == 0):
		velocity.x = lerpf(velocity.x, 0, FRICTION)
	else:
		velocity.x = lerpf(velocity.x, MOVEMENT_DIRECTION.x * MAX_SPEED, ACCELERATION)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()

func move(direction: Vector2) -> void:
	MOVEMENT_DIRECTION = direction

func jump()->void:
	if is_on_floor():
		position = Vector2(position.x,position.y)
		velocity.y = JUMP_VELOCITY

