extends TileMap

var n = 1000
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var x := []
var y := []
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(n):
		x.append(0)
		y.append(0)
	for i in range(n):
		var val = (randi() % 4) + 1
		match val:
			1:
				x[i] = x[i - 1] + 1
				y[i] = y[i - 1]
			2:
				x[i] = x[i - 1] - 1
				y[i] = y[i - 1]
			3:
				x[i] = x[i - 1]
				y[i] = y[i - 1] + 1
			4:
				x[i] = x[i - 1]
				y[i] = y[i - 1] - 1
	print("Start plotting.")
#	print(x)
	for i in range(n):
		for j in range(n):
			set_cell(i-n/2,j-n/2,0)
	for i in range(n):
		set_cell(x[i],y[i],1)
		var rand = randi()
		if rand % 12 == 7:
			print(Vector2(x[i],y[i]))
			Global.start_cell = Vector2(x[i],y[i])
		elif rand % 16 == 3:
			Global.coin_spawns.append(Vector2(x[i],y[i]))
		elif rand % 16 == 9:
			Global.spawn_cells.append(Vector2(x[i],y[i]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
