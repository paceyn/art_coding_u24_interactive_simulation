extends RigidBody2D

@export var radius = 50

var held = false


func _draw():
	draw_circle(Vector2.ZERO, radius, Color.BLACK)
	draw_arc(Vector2.ZERO, radius, 0, TAU, 360, Color.WHITE, 5, true)


func _unhandled_input(event):
	if event is InputEventMouseMotion and held:
		translate(event.relative)
	if event is InputEventMouseButton and not event.pressed:
		held = false


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		held = true


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Hitbox").shape.radius = radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not held:
		apply_central_force(-position)
