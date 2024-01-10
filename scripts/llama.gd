extends AnimatedSprite2D

var fuel: int

func _ready():
	randomize()
	self.frame = randi()%5
	fuel = randi()%300 + 300
	
func _physics_process(delta):
	fuel -= 1*delta
	if fuel <= 0:
		queue_free()
