extends CharacterBody2D

@export var speed := 320.0
@export var jump_force := 520.0
@export var gravity := 1200.0
@export var dash_speed := 700.0
@export var dash_time := 0.15

var dash_timer := 0.0
var is_dashing := false
var can_double_jump := true

func _physics_process(delta):
	apply_gravity(delta)
	handle_movement()
	handle_jump()
	handle_dash(delta)

	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement():
	var direction = Input.get_axis("move_left", "move_right")
	
	if not is_dashing:
		velocity.x = direction * speed

func handle_jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force
			can_double_jump = true
		elif can_double_jump:
			velocity.y = -jump_force
			can_double_jump = false

func handle_dash(delta):
	if Input.is_action_just_pressed("dash") and not is_dashing:
		is_dashing = true
		dash_timer = dash_time

	if is_dashing:
		dash_timer -= delta
		velocity.x = dash_speed * sign(velocity.x if velocity.x != 0 else 1)

		if dash_timer <= 0:
			is_dashing = false