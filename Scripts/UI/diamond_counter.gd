extends Node2D

var Diamonds: int = 0

func _process(delta: float) -> void:
	if str(Diamonds).split().size() == 1:
		$"Digit 1".frame = Diamonds
		$"Digit 2".visible = false
		$"Digit 3".visible = false
		$"Digit 4".visible = false
	elif str(Diamonds).split().size() == 2:
		$"Digit 1".frame = int(str(Diamonds).split().get(0))
		$"Digit 2".frame = int(str(Diamonds).split().get(1))
		$"Digit 2".visible = true
		$"Digit 3".visible = false
		$"Digit 4".visible = false
	elif str(Diamonds).split().size() == 3:
		$"Digit 1".frame = int(str(Diamonds).split().get(0))
		$"Digit 2".frame = int(str(Diamonds).split().get(1))
		$"Digit 3".frame = int(str(Diamonds).split().get(2))
		$"Digit 2".visible = true
		$"Digit 3".visible = true
		$"Digit 4".visible = false
	else:
		$"Digit 1".frame = int(str(Diamonds).split().get(0))
		$"Digit 2".frame = int(str(Diamonds).split().get(1))
		$"Digit 3".frame = int(str(Diamonds).split().get(2))
		$"Digit 4".frame = int(str(Diamonds).split().get(3))
		$"Digit 2".visible = true
		$"Digit 3".visible = true
		$"Digit 4".visible = true
	if Diamonds > 9999:
		Diamonds = 9999
