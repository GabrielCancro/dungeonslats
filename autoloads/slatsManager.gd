extends Node

var GAME
var SLATTER
const it = .65
var SLAT_COLORS = {
	"SW":Color(1,.6,.6), 
	"GR":Color(.8,.9,.9), 
	"EY":Color(.7,.7,1), 
	"BT":Color(.4,1,.6), 
	"SC":Color(1,1,.6), 
	"SH":Color(.6,.6,.6)
}


# Called when the node enters the scene tree for the first time.
func _init_slat_manager(_GAME):
	GAME = _GAME
	SLATTER = GAME.get_node("Slatter")
	
func assign_slat(type):
	var slat = SLATTER.get_valid_slat(type)
	if slat:
		slat.consume()
		return true
	return false

func get_color(type):
	return SLAT_COLORS[type]
