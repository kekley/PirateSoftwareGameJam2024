extends Camera2D

var followTarget : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	followTarget = (get_tree().root.get_node("Main/Player") as Player).movementComponent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = followTarget.global_position
