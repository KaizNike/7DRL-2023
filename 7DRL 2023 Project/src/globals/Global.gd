extends Node

const version = [1,0,2]
# v 1.0.2 - Robber's Haul
# Edited spawn rates # Added check for player auto movement

var start_cell := Vector2.ZERO
var spawn_cells := []
var coin_spawns := []
var coin_count := 0

var win := false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
