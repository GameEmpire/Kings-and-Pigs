extends RigidBody2D

func _on_detector_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		if scene_file_path == "res://Scenes/Collectables/diamond.tscn":
			get_tree().get_first_node_in_group("Diamonds counter").Diamonds += 1
		else:
			get_tree().get_first_node_in_group("Player").gain_life()
		$Sprite.play("Collect")
		await get_tree().create_timer(0.2).timeout
		queue_free()
