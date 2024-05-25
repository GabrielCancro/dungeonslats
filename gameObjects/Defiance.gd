extends Node2D

var defiance_data

func set_data(_data):
	defiance_data = _data
	$Sprite.texture = load("res://assets/room/def_"+defiance_data["type"]+".png")
	$Label.text = str(defiance_data["lvl"])
