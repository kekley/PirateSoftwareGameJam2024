extends CharacterBody2D

var MOVEMENT_DIRECTION :Vector2
@export var ACCELERATION: float = .4
@export var MAX_SPEED: float = 400
@export var FRICTION: float = .2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if (MOVEMENT_DIRECTION.x == 0):
		velocity.x = lerpf(velocity.x, 0, FRICTION)
	else:
		velocity.x = lerpf(velocity.x, MOVEMENT_DIRECTION.x * MAX_SPEED, ACCELERATION)
		
	if (MOVEMENT_DIRECTION.y == 0):
		velocity.y = lerpf(velocity.y, 0, FRICTION)
	else:
		velocity.y = lerpf(velocity.y, MOVEMENT_DIRECTION.y * MAX_SPEED, ACCELERATION)
	move_and_slide()

func move(direction: Vector2) -> void:
	MOVEMENT_DIRECTION = direction
