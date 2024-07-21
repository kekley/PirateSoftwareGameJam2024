extends CharacterBody2D

var INPUT_DIRECTION: Vector2;
@export var ACCELERATION: float = .4
@export var MAX_SPEED: float = 400
@export var FRICTION: float = .2
@export var GRAVITY: float = 800
@export var JUMP_VELOCITY : float = -400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	INPUT_DIRECTION = Input.get_vector("Left", "Right", "Up", "Down")

func _input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	if (INPUT_DIRECTION.x == 0):
		velocity.x = lerpf(velocity.x, 0, FRICTION)
	else:
		velocity.x = lerpf(velocity.x, INPUT_DIRECTION.x * MAX_SPEED, ACCELERATION)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	move_and_slide()
