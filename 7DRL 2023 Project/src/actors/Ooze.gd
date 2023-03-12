extends KinematicBody2D

onready var vision = $RayCast2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const relation = "OOZE"
const stats = {"PHY_DMG": 1, "RNG_DMG": 1, "HP": 12}
var currentStats = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	currentStats = stats.duplicate(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take_turn():
	var dir = Vector2(randi()%3-1,randi()%3-1)
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
	
	
func deal_dmg(dmg):
	if currentStats.HP - dmg <= 0:
		queue_free()
	else:
		currentStats.HP -= dmg
		$AnimationPlayer.play("take_dmg")
