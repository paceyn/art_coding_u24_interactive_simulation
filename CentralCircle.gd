extends RigidBody2D

@export var radius = 50

var held = false


func _draw():
	draw_circle(Vector2.ZERO, radius, Color.BLACK)
	draw_arc(Vector2.ZERO, radius, 0, TAU, 360, Color.WHITE, 5, true)


func _unhandled_input(event):
	if event is InputEventMouseMotion and held:
		PhysicsServer2D.body_set_state(
			get_rid(),
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			transform.translated(event.relative)
		)
		translate(event.relative)
		linear_velocity = Vector2.ZERO
	if event is InputEventMouseButton and not event.pressed:
		held = false


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		held = true


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Hitbox").shape.radius = radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not held:
		apply_central_force(-1000 * position)
