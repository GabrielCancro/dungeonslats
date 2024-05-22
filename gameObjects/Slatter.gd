extends Control

var slats = {"SW":4, "HN":4, "EY":4, "BT":4, "SC":4}
var is_rolling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"roll_slats")
	

func roll_slats():
	is_rolling = true
	$Button.disabled = is_rolling
	Utils.remove_all_childs($SlatContainer)
	for key in slats.keys():
		for i in range(slats[key]):
			var slat_node = load("res://gameObjects/Slat.tscn").instance()
			slat_node.set_slat(key)
			$SlatContainer.add_child(slat_node)
	yield(get_tree().create_timer(1.2),"timeout")
	collect_slats()
	yield(get_tree().create_timer(2),"timeout")
	is_rolling = false
	$Button.disabled = is_rolling

func collect_slats():
	var v = 0
	var i = 0
	for slat in $SlatContainer.get_children():
		yield(get_tree().create_timer(.06),"timeout")
		if slat.isValid: 
			slat.goto_file(v)
			v+=1
		else:
			slat.goto_file(i)
			i+=1
