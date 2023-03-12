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
	var x = randi()%3-1
	var y = 0
	if not x:
		y = randi()%3-1
	var dir = Vector2(x,y)
#	print(dir)
	vision.cast_to = dir * 16
	vision.enabled = true
	vision.force_raycast_update()
	if vision.is_colliding():
#		print("Blocked!")
		vision.enabled = false
		return
	else:
		position += dir * 16
		vision.enabled = false
	
	
func deal_dmg(dmg):
	if currentStats.HP - dmg <= 0:
		Global.emit_signal("on_Actor_Death", self.global_position)
		$AnimationPlayer.play("death")
#		queue_free()
	else:
		currentStats.HP -= dmg
		$AnimationPlayer.play("take_dmg")
