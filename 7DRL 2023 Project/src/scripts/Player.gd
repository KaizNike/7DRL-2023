extends KinematicBody2D

onready var vision = $RayCast2D
# Declare member variables here. Examples:
var wandering = false
var wanderTurns = 20
var currentWander = 0
var zoomSpeed = 0.85

const stats = {"PHY_DMG": 2, "RNG_DMG": 8, "HP": 6}

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
func _get_direction() -> Vector2:
	return Vector2(
		-Input.get_action_raw_strength("move_left") + Input.get_action_raw_strength("move_right"),
		Input.get_action_raw_strength("move_down") - Input.get_action_raw_strength("move_up")
	)


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
		dir = _get_direction()
##		if Input.is_action_just_pressed("move_upleft"):
##			dir = Vector2(-1,-1)
#		if Input.is_action_just_pressed("move_up"):
#			dir = Vector2(0,-1)
##		elif Input.is_action_just_pressed("move_upright"):
##			dir = Vector2(1,-1)
#		elif Input.is_action_just_pressed("move_left"):
#			dir = Vector2(-1,0)
#		elif Input.is_action_just_pressed("move_right"):
#			dir = Vector2(1,0)
##		elif Input.is_action_just_pressed("move_downleft"):
##			dir = Vector2(-1,1)
#		elif Input.is_action_just_pressed("move_down"):
#			dir = Vector2(0,1)
##		elif Input.is_action_just_pressed("move_downright"):
##			dir = Vector2(1,1)
	print(dir)
	vision.cast_to = dir * 16
	vision.enabled = true
	vision.force_raycast_update()
	if vision.is_colliding():
		var obj = vision.get_collider()
		if obj.is_in_group("grabable"):
			obj.queue_free()
			Global.coin_count += 1
			if Global.coin_count >= Global.coin_spawns.size():
				Global.win = true
				queue_free()
		elif obj.is_in_group("actionable") and "relation" in obj:
			if obj.relation != "TEAM" or obj.relation != "NEUTRAL":
				obj.deal_dmg(stats.PHY_DMG)
			pass
		print("Blocked!")
		vision.enabled = false
		return
	else:
		position += dir * 16
		vision.enabled = false
