extends KinematicBody2D

onready var vision = $RayCast2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take_turn():
#	Need to know whats a wall.
	var rand = Vector2(randi()%3-1,randi()%3-1)
	print(rand)
	vision.cast_to = rand * 16
	vision.enabled = true
	vision.force_raycast_update()
	if vision.is_colliding():
		print("Blocked!")
		vision.enabled = false
		return
	else:
		position += rand * 16
		vision.enabled = false
