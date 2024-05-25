extends Node2D

var door_data

# Called when the node enters the scene tree for the first time.
func set_data(_data):
	door_data = _data
	if door_data.tileB.x-door_data.tileA.x == 0: $SpriteH.visible = false
	else: $SpriteV.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
