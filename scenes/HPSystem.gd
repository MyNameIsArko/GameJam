extends TextureRect

@export var hp_array: Array[Texture2D]

func calculate_hp(hp: float):
	var id = round(hp * 2)
	texture = hp_array[id]
