extends Node

var GAME
var SLATTER


# Called when the node enters the scene tree for the first time.
func _init_slat_manager(_GAME):
	GAME = _GAME
	SLATTER = GAME.get_node("CanvasLayerUI/Slatter")
	
func assign_slat(type):
	var slat = SLATTER.get_valid_slat(type)
	if slat:
		slat.consume()
		return true
	return false
