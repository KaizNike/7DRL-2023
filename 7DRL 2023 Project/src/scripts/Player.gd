extends KinematicBody2D

onready var vision = $RayCast2D
# Declare member variables here. Examples:
var wandering = false
var wanderTurns = 20
var currentWander = 0
var zoomSpeed = 0.85

func _input(event):
	if event.is_action_pressed("mouse_wheelup"):
		$Camera2D.zoom /= zoomSpeed
	elif event.is_action_pressed("mouse_wheeldown"):
		$Camera2D.zoom *= zoomSpeed
	if event.is_action_pressed("wander") and not wandering:
		wandering = true
		
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take_turn():
	var dir = Vector2.ZERO
#	Need to know whats a wall.
	if wandering and currentWander < wanderTurns:
		currentWander += 1
		if currentWander >= wanderTurns:
			wandering = false
			currentWander = 0
		dir = Vector2(randi()%3-1,randi()%3-1)
	else:
#		if Input.is_action_just_pressed("move_upleft"):
#			dir = Vector2(-1,-1)
		if Input.is_action_just_pressed("move_up"):
			dir = Vector2(0,-1)
#		elif Input.is_action_just_pressed("move_upright"):
#			dir = Vector2(1,-1)
		elif Input.is_action_just_pressed("move_left"):
			dir = Vector2(-1,0)
		elif Input.is_action_just_pressed("move_right"):
			dir = Vector2(1,0)
#		elif Input.is_action_just_pressed("move_downleft"):
#			dir = Vector2(-1,1)
		elif Input.is_action_just_pressed("move_down"):
			dir = Vector2(0,1)
#		elif Input.is_action_just_pressed("move_downright"):
#			dir = Vector2(1,1)
	print(dir)
	vision.cast_to = dir * 16
	vision.enabled = true
	vision.force_raycast_update()
	if vision.is_colliding():
		print("Blocked!")
		vision.enabled = false
		return
	else:
		position += dir * 16
		vision.enabled = false
