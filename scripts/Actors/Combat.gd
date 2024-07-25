class_name Combat
extends Node2D

@export var HP :int = 10
@export var ATTACK : int = 5
@export var DEFENSE : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(HP<=0):
		die()

func meleeAttack(target:Combat) -> void:
	target.takeDamage(ATTACK)
	
func shootProjectile() -> void:
	pass

func die() -> void:
	print("man im dead")
	
func takeDamage(attackValue:int) ->void:
	HP-=attackValue-DEFENSE
