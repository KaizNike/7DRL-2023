extends Node

var waiting_on_input = true
export (PackedScene) var enemy
export (PackedScene) var coin
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var wanderTurns = 0
var currentWander = 0

func _input(event):
	if (Input.is_action_just_pressed("move_upleft") or
	Input.is_action_just_pressed("move_up") or
	Input.is_action_just_pressed("move_upright") or
	Input.is_action_just_pressed("move_left") or
	Input.is_action_just_pressed("move_right") or
	Input.is_action_just_pressed("move_downleft") or
	Input.is_action_just_pressed("move_down") or
	Input.is_action_just_pressed("move_downright") or
	Input.is_action_just_pressed("wait")):
		waiting_on_input = false
		_process(0)
	if Input.is_action_just_pressed("wander"):
		currentWander = $Player.currentWander
		waiting_on_input = false
		_process(0)
#	if event.is_action_pressed("ui_accept"):
#		waiting_on_input = false
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = Global.start_cell * 16
	wanderTurns = $Player.wanderTurns
	print(Global.spawn_cells.size())
	for spawn in Global.spawn_cells:
		var new = enemy.instance()
		new.position = spawn * 16
		self.add_child(new)
	for newCoin in Global.coin_spawns:
		var new = coin.instance()
		new.position = newCoin * 16
		self.add_child(new)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.win:
		$Control/Winning.visible = true
		return
#	if (Input.get_action_strength("move_down") or
#	Input.get_action_strength("move_left") or
#	Input.get_action_strength("move_right") or
#	Input.get_action_strength("move_up") or
#	Input.is_action_pressed("wait")):
#		waiting_on_input = false
	if currentWander <= wanderTurns and $Player.wandering:
		waiting_on_input = false
		currentWander += 1
	if not waiting_on_input or currentWander < wanderTurns:
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
