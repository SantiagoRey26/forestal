extends Node

var foco = preload("res://scns/fuego.tscn")
var terreno = Node
var level = Node

var combustible: Array

func _ready():
	terreno = get_node("/root/Level/Terreno")
	level = get_node("/root/Level")
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.autostart = true
	timer.wait_time = 3
	timer.timeout.connect(_avance_del_fuego)
	timer.start()
	
func _physics_process(delta):
	print(combustible)

func _avance_del_fuego():
	if !combustible.is_empty():
		for i in combustible:
			var newFoco = foco.instantiate()
			level.add_child(newFoco)
			newFoco.position = i
			combustible.erase(i)
		
