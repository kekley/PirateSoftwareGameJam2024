class_name Player
extends Node2D

var controller : PlayerController
var movementComponent: SideScrollingMovement
var combatComponent: Combat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		controller = $PlayerController
		movementComponent = $PlayerController/SideScrollingMovement
		combatComponent = $PlayerController/Combat


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
