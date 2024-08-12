extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	points[1] = get_node("CentralCircle").position
	width = (points[1] - points[0]).length() / 50
