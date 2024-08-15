extends Node2D

@export var probability = 0.005

@export var min_radius = 25
@export var max_radius = 50

@export var min_point_count = 3
@export var max_point_count = 6

var shapes = []
var random


func _ready():
	random = RandomNumberGenerator.new()


func _process(_delta):
	if (random.randf() < probability):
		shapes.append(load("res://floating_shape.tscn").instantiate())
		shapes[-1].radius = random.randf_range(min_radius, max_radius)
		shapes[-1].point_count = min_point_count + (randi() % (max_point_count - min_point_count))
		
		var initial_y = random.randf_range(-400, 400)
		
		shapes[-1].get_node("ShapeBody").package = [initial_y, random.randf_range(0, 360), Vector2(random.randf_range(20, 40), random.randf_range(-10, 10)), random.randf_range(-5, 5)]
		shapes[-1].get_node("ShapeBody").initial_y = initial_y
		add_child(shapes[-1])
	
	if shapes.size() > 0:
		if shapes[0].opacity < 0:
			shapes[0].queue_free()
			shapes.pop_front()
