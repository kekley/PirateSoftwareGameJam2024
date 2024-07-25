class_name WanderingEnemy
extends Node

var AIComponent : WanderingAI


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AIComponent  = $WanderingAI


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
