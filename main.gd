extends Node2D

@export var probability = 0.01

@export var min_radius = 25
@export var max_radius = 50

@export var min_point_count = 3
@export var max_point_count = 6

var shapes = []
var random
var noise

var timing = 10000


func spawn():
	shapes.append(load("res://floating_shape.tscn").instantiate())
	shapes[-1].radius = random.randf_range(min_radius, max_radius)
	shapes[-1].point_count = min_point_count + (randi() % (max_point_count - min_point_count + 1))

	var initial_y = 400 * noise.get_noise_1d(timing)

	shapes[-1].get_node("ShapeBody").package = [initial_y, random.randf_range(0, 360), Vector2(random.randf_range(60, 80), random.randf_range(-10, 10)), random.randf_range(-2, 2)]
	shapes[-1].get_node("ShapeBody").initial_y = initial_y

	shapes[-1].get_node("ShapeBody").initial_x = -1 if random.randf() < 0.5 else 1

	add_child(shapes[-1])


func _ready():
	random = RandomNumberGenerator.new()
	noise = FastNoiseLite.new()
	
	spawn()


func _process(delta):
	timing += 10 * delta
	
	if (random.randf() < probability):
		spawn()
	
	if shapes.size() > 0:
		if shapes[0].opacity < 0:
			shapes[0].queue_free()
			shapes.pop_front()
