extends Node2D

func take_damage():
	if $Heart1.visible:
		$Heart1.play("Hit")
		await get_tree().create_timer(0.2).timeout
		$Heart1.visible = false
	elif $Heart2.visible:
		$Heart2.play("Hit")
		await get_tree().create_timer(0.2).timeout
		$Heart2.visible = false
	elif $Heart3.visible:
		$Heart3.play("Hit")
		await get_tree().create_timer(0.2).timeout
		$Heart3.visible = false

func gain_life():
	if not $Heart3.visible:
		$Heart3.visible = true
		$Heart3.play("Hit", -1, true)
		await get_tree().create_timer(0.2).timeout
		$Heart3.play("Idle")
	elif not $Heart2.visible:
		$Heart2.visible = true
		$Heart2.play("Hit", -1, true)
		await get_tree().create_timer(0.2).timeout
		$Heart2.play("Idle")
	elif not $Heart1.visible:
		$Heart1.visible = true
		$Heart1.play("Hit", -1, true)
		await get_tree().create_timer(0.2).timeout
		$Heart1.play("Idle")
