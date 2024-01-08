extends Sprite2D

var terreno: Node
var compFuego: Node

var currPos = Vector2i()
var surrTiles = []

func _ready():
	compFuego = get_node("/root/CompFuego")
	terreno = get_node("/root/Level/Terreno")
	currPos = terreno.local_to_map(position)
	surrTiles = terreno.get_surrounding_cells(currPos)
	surrTiles.append(currPos + Vector2i(1,1))
	surrTiles.append(currPos + Vector2i(-1,1))
	surrTiles.append(currPos + Vector2i(-1,-1))
	surrTiles.append(currPos + Vector2i(1,-1))
	check_for_fire()

func check_for_fire():
	for i in surrTiles:
		var data = terreno.get_cell_tile_data(0, i)
		var esQuemable = data.get_custom_data("quemable")
		if esQuemable && !compFuego.combustible.has(i):
			compFuego.combustible.append(i)

#func _on_timer_timeout():
	#check_for_fire()
