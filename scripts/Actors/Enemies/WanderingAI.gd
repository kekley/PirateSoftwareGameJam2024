class_name WanderingAI
extends Node

var targetPlayer : Player 
enum AIState {Wandering,Chasing,Attacking,Shooting,Jumping,Cooldown,Initializing}

signal CONTACT_HITBOX_ENTERED(area:Area2D)

var currentState : AIState = AIState.Initializing
var currentDirection : Vector2

var stateTimer: Timer = Timer.new()
var cooldownTimer: Timer = Timer.new()
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var movementComponent : SideScrollingMovement
var combatComponent : Combat

@export var CHASE_DISTANCE :float = 200
@export var ESCAPE_DISTANCE :float = 250
@export var JUMP_TRIGGER_HEIGHT : float = -25 #negative because the top of the screen is 0 on the y axis
@export var WANDER_TIMER: float = 3
@export var COOLDOWN_TIMER:float = 1.3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	stateTimer.wait_time = WANDER_TIMER
	stateTimer.autostart = false
	stateTimer.one_shot = true
	add_child(stateTimer)
	
	cooldownTimer.wait_time = COOLDOWN_TIMER
	cooldownTimer.autostart = false
	cooldownTimer.one_shot = true
	add_child(cooldownTimer)
	
	targetPlayer= get_tree().root.get_node("Main/Player")
	movementComponent = $SideScrollingMovement
	combatComponent = $Combat


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match currentState:
		AIState.Initializing:
			currentState = AIState.Wandering
			if(rng.randi_range(0,99)>49):
				moveLeft()
			else:
				moveRight()
			stateTimer.start()
		AIState.Wandering:
			if distanceToPlayer()<CHASE_DISTANCE : #player in range
				currentState = AIState.Chasing
			else: #player not in range
				if(stateTimer.is_stopped()):
					turnAround()
					stateTimer.start()
		AIState.Chasing:
			if(distanceToPlayer()>ESCAPE_DISTANCE):
				currentState = AIState.Wandering
			if(targetPlayer.movementComponent.global_position.x < movementComponent.global_position.x):
				moveLeft()
			if(targetPlayer.movementComponent.global_position.x > movementComponent.global_position.x):
				moveRight()
			if((targetPlayer.movementComponent.global_position.y - movementComponent.global_position.y)<JUMP_TRIGGER_HEIGHT):
				jump()
				currentState = AIState.Jumping
		AIState.Attacking:
			combatComponent.meleeAttack()
			#animate here
			doCooldown()
			currentState = AIState.Cooldown
		AIState.Cooldown:
			if(!cooldownTimer.is_stopped()):
				pass
			else:
				currentDirection = Vector2(1,0)
				currentState = AIState.Wandering
		AIState.Shooting:
			pass
		AIState.Jumping:
			if(!movementComponent.is_on_floor()):
				pass
			else:
				doCooldown()
				currentState = AIState.Cooldown
		_:
			pass
	movementComponent.move(currentDirection)

func distanceToPlayer() -> float:
	return movementComponent.global_position.distance_to(targetPlayer.movementComponent.global_position)

func chasePlayer() ->void:
	pass

func resetTimer()->void:
	stateTimer.stop()
	stateTimer.start()
	
func doCooldown()->void:
	cooldownTimer.stop()
	cooldownTimer.start()
	
func wander() ->void:
	pass
	
func jump() ->void:
	movementComponent.jump()
	
func moveLeft() ->void:
	currentDirection = Vector2(-1,0)
	
func moveRight()->void:
	currentDirection = Vector2(1,0)
	
func turnAround()->void:
	currentDirection *=-1
	
func attackAction()->void:
	pass

func shootAction()->void:
	pass

func _on_contact_damage_hitbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print(area.name)
