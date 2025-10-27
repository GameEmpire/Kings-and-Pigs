extends CharacterBody2D

@export var Speed: int = 130
@export var Jump_velocity: int = 260
@export_range(1, 3) var health: int = 3
var state: String = "none"
var can_move: bool = true
var falling: bool = false
@onready var sprite: AnimatedSprite2D = $Sprite

func _ready() -> void:
	$Huds.visible = true
	Jump_velocity = -Jump_velocity
	take_damage()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		falling = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_move:
		velocity.y = Jump_velocity

	if velocity.x > 0:
		sprite.scale.x = 1
	elif velocity.x < 0:
		sprite.scale.x = -1

	play_animations()
	Handle_attack()
	Handle_ground()
	if can_move:
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * Speed
		else:
			velocity.x = move_toward(velocity.x, 0, Speed)

	move_and_slide()

func take_damage():
	health -= 1
	$"Huds/Live bar".take_damage()

func gain_life():
	health += 1
	$"Huds/Live bar".gain_life()

func play_animations():
	if is_on_floor():
		if state == "Attacking":
			sprite.play("Attack")
		elif state == "Ground":
			sprite.play("Ground")
		elif state == "Door in":
			sprite.play("Door in")
		elif state == "Door out":
			sprite.play("Door out")
		elif velocity.x == 0:
			sprite.play("Idle")
		else:
			sprite.play("Run")
	else:
		if velocity.y < 0:
			sprite.play("Jump")
		else:
			sprite.play("Fall")

func Handle_ground():
	if is_on_floor() and falling:
		falling = false
		state = "Ground"
		await get_tree().create_timer(0.1).timeout
		state = "none"

func Handle_attack():
	if Input.is_action_just_pressed("attack"):
		state = "Attacking"
		await get_tree().create_timer(0.3).timeout
		state = "none"
