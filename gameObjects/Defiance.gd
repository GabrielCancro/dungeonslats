extends Node2D

var defiance_data

func set_data(_data):
	defiance_data = _data
	defiance_data["node_ref"] = self
	$Sprite.texture = load("res://assets/room/def_"+defiance_data["type"]+".png")
	$Label.text = str(defiance_data["lv"])
	
	Utils.remove_all_childs($Actions)
	for ac_data in defiance_data.actions:
		var anode = preload("res://gameObjects/ActionLine.tscn").instance()
		ac_data["defiance_data"] = defiance_data
		anode.set_data(ac_data)
		$Actions.add_child(anode)
		var i = anode.get_index()
		anode.rect_position.y = -70 + 35*i
		anode.rect_position.x += i%2*15

func _process(delta):
	if (get_global_mouse_position().distance_to(global_position+Vector2(20,-30)) < 70):
		if !$Actions.visible: EffectManager.intro_actions($Actions)
	else: 
		if $Actions.visible: EffectManager.outro_actions($Actions)
