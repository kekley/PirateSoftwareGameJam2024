extends CharacterBody2D

var inputDirection: Vector2;
@export var acceleration: float = .3
@export var maxSpeed: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	inputDirection = Input.get_vector("Left", "Right", "Down", "Up")

func _input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass