extends TileMap

@onready var foco = preload("res://forestal/scns/llama.tscn")

var diagCells = []
var ortoCells = []
var fireCells = []

func _ready():
	randomize()
	get_fuel()
	ignite()
	#var iniFoco = foco.instantiate()
	#
	#$Focos.add_child(iniFoco)

func get_fuel():
	fireCells = self.get_used_cells_by_id(0, 0, Vector2(4,0))
#ver si las ortogonales no estan mapeadas, agregarlas a ortocells
	for i in fireCells:
		var sideCells = self.get_surrounding_cells(i)
		for x in sideCells:
			if !ortoCells.has(x):
				ortoCells.append(x)
#ver si las diagonales estan mapedadas, sino agregarlas al array
	for i in fireCells:
		var tempDiagCells = [i + Vector2i(1,1), i + Vector2i(-1,1), i + Vector2i(-1,-1), i + Vector2i(1,-1)]
		for x in tempDiagCells:
			if !diagCells.has(x):
				diagCells.append(x)
	
func ignite():
#si las tiles de al rededor son quemables, quemarlas
	var quemadas = []
	for i in ortoCells:
		var data = self.get_cell_tile_data(0,i)
		if data.get_custom_data("quemable"):
			if randi()%100+1 < 80:
				self.set_cell(0,i,0, Vector2(4,0))
				quemadas.append(i)
	for i in diagCells:
		var data = self.get_cell_tile_data(0,i)
		if data.get_custom_data("quemable"):
			if randi()%100+1 < 50:
				self.set_cell(0,i,0, Vector2(4,0))
				quemadas.append(i)
	for i in quemadas:
		var newFoco = foco.instantiate()
		newFoco.position = self.map_to_local(i)
		$Focos.add_child(newFoco)
		if ortoCells.has(i):
			ortoCells.remove_at(ortoCells.find(i))
		else:
			diagCells.remove_at(diagCells.find(i))
			
			
func _on_timer_timeout():
	get_fuel()
	ignite()
