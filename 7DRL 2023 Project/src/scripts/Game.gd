extends Node

var waiting_on_input = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _input(event):
	if event.is_action_pressed("ui_accept"):
		waiting_on_input = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not waiting_on_input:
		var group = get_children()
		for child in group:
			if child.is_in_group("actionable"):
				if child.has_method("take_turn"):
					child.take_turn()
				else:
					print('Missing function to live!')
		waiting_on_input = true

func get_cell(pos:Vector2):
	return $TileMap.get_cellv(pos)
