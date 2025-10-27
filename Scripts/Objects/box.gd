extends StaticBody2D

var can_hit: bool = false
var health: int = 3
@export var heart: bool = false
@export var diamond: bool = false
var hit: bool = false

func _process(delta: float) -> void:
	if can_hit:
		if get_tree().get_first_node_in_group("Player").state == "Attacking" and not hit:
			$Sprite.play("Hit")
			health -= 1
			hit = true
			if health < 1:
				break_into_piees()
		elif hit and not get_tree().get_first_node_in_group("Player").state == "Attacking":
			hit = false
			$Sprite.play("Idle")
	else:
		hit = false
		$Sprite.play("Idle")

func break_into_piees():
	if heart:
		var heart_scene = preload("res://Scenes/Collectables/heart.tscn").instantiate()
		heart_scene.global_position = global_position
		heart_scene.linear_velocity = Vector2(150 if get_tree().get_first_node_in_group("Player").position.x < position.x else -150, randi_range(-100, -200))
		add_sibling(heart_scene)
	if diamond:
		var diamond_scene = preload("res://Scenes/Collectables/diamond.tscn").instantiate()
		diamond_scene.global_position = global_position
		diamond_scene.linear_velocity = Vector2(150 if get_tree().get_first_node_in_group("Player").position.x < position.x else -150, randi_range(-100, -200))
		add_sibling(diamond_scene)
	var pieces = preload("res://Scenes/Objects/box_pieces.tscn").instantiate()
	add_sibling(pieces)
	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$Detector/CollisionShape2D.disabled = true
	pieces.global_position = global_position
	await get_tree().create_timer(2).timeout
	pieces.queue_free()
	queue_free()

func _on_detector_body_entered(body: CharacterBody2D) -> void:
	can_hit = true

func _on_detector_body_exited(body: CharacterBody2D) -> void:
	can_hit = false
