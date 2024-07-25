class_name WanderingAI
extends Node

var targetPlayer : Player 
enum AIState {Wandering,Chasing,Attacking,Shooting,PreJump,Jumping,Falling,Cooldown,Initializing}

signal CONTACT_HITBOX_ENTERED(area:Area2D)

var currentState : AIState = AIState.Initializing
var currentDirection : Vector2
var frameCount :int = 0
var behaviorFrameCount :int = 0
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var movementComponent : SideScrollingMovement
var combatComponent : Combat

@export var CHASE_DISTANCE :float = 500
@export var ESCAPE_DISTANCE :float = 501
@export var JUMP_TRIGGER_HEIGHT : float = -25 #negative because the top of the screen is 0 on the y axis
@export var WANDER_FRAMES: int = 90
@export var COOLDOWN_FRAMES: int = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	targetPlayer= get_tree().root.get_node("Main/Player")
	movementComponent = $SideScrollingMovement
	combatComponent = $Combat

func _physics_process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	frameCount+=1
	match currentState:
		AIState.Initializing:
			if(rng.randi_range(0,99)>49):
				moveLeft()
			else:
				moveRight()
			transitionState(AIState.Wandering)
		AIState.Wandering:
			if distanceToPlayer()<CHASE_DISTANCE : #player in range
				transitionState(AIState.Chasing)
			else: #player not in range
				if(behaviorFrameCount%WANDER_FRAMES==0):
					turnAround()
		AIState.Chasing:
			if(distanceToPlayer()>ESCAPE_DISTANCE):
				transitionState(AIState.Wandering)
			if(targetPlayer.movementComponent.global_position.x < movementComponent.global_position.x):
				moveLeft()
			if(targetPlayer.movementComponent.global_position.x > movementComponent.global_position.x):
				moveRight()
			if((targetPlayer.movementComponent.global_position.y - movementComponent.global_position.y)<JUMP_TRIGGER_HEIGHT and distanceToPlayer()<150):
				jump()
		AIState.Attacking:
			combatComponent.meleeAttack(targetPlayer.combatComponent)
			#animate here
			transitionState(AIState.Cooldown)
		AIState.Cooldown:
			if(!(behaviorFrameCount%COOLDOWN_FRAMES==0)):
				currentDirection = (Vector2(0,0))
			else:
				currentDirection = Vector2(1,0)
				transitionState(AIState.Wandering)
		AIState.Shooting:
			pass
		AIState.PreJump:
			if(movementComponent.velocity.y==0):
				transitionState(AIState.Wandering)
			if(!movementComponent.is_on_floor()):
				transitionState(AIState.Jumping)
		AIState.Jumping:
			if(!movementComponent.is_on_floor()):
				pass
			else:
				transitionState(AIState.Cooldown)
		_:
			pass
	behaviorFrameCount+=1
	movementComponent.move(currentDirection)

func distanceToPlayer() -> float:
	return movementComponent.global_position.distance_to(targetPlayer.movementComponent.global_position)

func transitionState(state:AIState) ->void:
	print(AIState.keys()[state])
	currentState = state
	behaviorFrameCount=0

func jump() ->void:
	movementComponent.jump()
	currentState=AIState.PreJump
	
func moveLeft() ->void:
	currentDirection = Vector2(-1,0)
	
func moveRight()->void:
	currentDirection = Vector2(1,0)
	
func turnAround()->void:
	currentDirection *=-1
	
func attackAction()->void:
	AIState.Attacking
	bump(targetPlayer.movementComponent,2000)
	combatComponent.meleeAttack(targetPlayer.combatComponent)

func shootAction()->void:
	pass

func bump(target:SideScrollingMovement,force:float)->void:
	print(target.velocity)
	target.velocity += -(movementComponent.global_position-target.global_position).normalized()*force
	print(target.velocity)
	print((movementComponent.global_position-target.global_position).normalized()*force)

func _on_contact_damage_hitbox_area_entered(area: Area2D) -> void:
	if(area.name=="Hurtbox"):
		attackAction()
