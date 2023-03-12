extends Node

const version = [1,1,1]
# v 1.1.0 - Robber's Haul
# Combat Update, Death Update

var start_cell := Vector2.ZERO
var spawn_cells := []
var coin_spawns := []
var coin_count := 0

var win := false

signal on_Actor_Death

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
