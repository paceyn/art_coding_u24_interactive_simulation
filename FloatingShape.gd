extends RigidBody2D

var visual
var outline
var hitbox

var initial_y = null
var package = null

func _integrate_forces(state):
	if package != null:
		state.transform = Transform2D(package[1], Vector2(-1000, package[0]))
		state.linear_velocity = package[2]
		state.angular_velocity = package[3]
	package = null


func _ready():
	visual = $Visual
	outline = $Outline
	hitbox = $Hitbox
	
	var points = []
	
	var radius = get_parent().radius
	var point_count = get_parent().point_count
	
	visual.polygon.resize(point_count)
	outline.points.resize(point_count)
	hitbox.polygon.resize(point_count)
	
	for i in range(point_count):
		var theta = 2 * PI * i / point_count
		points.append(Vector2(radius * cos(theta), radius * sin(theta)))
		
	var points_packed = PackedVector2Array(points)
	
	visual.polygon = points_packed.duplicate()
	outline.points = points_packed.duplicate()
	hitbox.polygon = points_packed.duplicate()
	
	position = Vector2(-1000, initial_y)
	

func _process(delta):
	get_parent().opacity -= 0.02 * delta
	
	visual.color = Color(0, 0, 0, get_parent().opacity)
	outline.default_color = Color(1, 1, 1, get_parent().opacity)
