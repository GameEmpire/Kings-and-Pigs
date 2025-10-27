extends Area2D

var can_enter: bool = true
var state: String = "Idle"
var player: CharacterBody2D
@onready var sprite: AnimatedSprite2D = $Sprite

func _process(delta: float) -> void:
	if state == "Idle" or state == "Closed":
		sprite.play("Idle")
	elif state == "Open":
		sprite.play("Open")
	elif state == "Opening":
		sprite.play("Opening")
	elif state == "Closing":
		sprite.play("Closing")

	if can_enter and Input.is_action_just_pressed("door"):
		if state == "Idle":
			player.can_move = false
			player.position.x = position.x
			player.velocity.x = 0
			state = "Opening"
			await get_tree().create_timer(0.5).timeout
			state = "Open"
			player.state = "Door in"
			await get_tree().create_timer(0.8).timeout
			player.state = "none"
			player.visible = false
			state = "Closing"
			await get_tree().create_timer(0.3).timeout
			state = "Closed"
		elif state == "Closed":
			state = "Opening"
			await get_tree().create_timer(0.5).timeout
			player.state = "Door out"
			player.visible = true
			state = "Open"
			await get_tree().create_timer(0.8).timeout
			player.state = "none"
			state = "Closing"
			await get_tree().create_timer(0.3).timeout
			state = "Idle"
			player.can_move = true

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		player = body
		can_enter = true

func _on_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		can_enter = false
