extends Node

var DEFIANCES = {
	"enemy":{"lv":3, "damage":2, "actions":[ 
		{"name":"attack","req":{"SW":1} }, 
		{"name":"evade","req":{"BT":2} } 
	]},
	"trap":{"lv":3, "damage":1, "actions":[ 
		{"name":"attack","req":{"SW":3} }, 
		{"name":"evade","req":{"BT":2} } 
	]},
	"chest":{"lv":3, "actions":[ 
		{"name":"attack","req":{"SW":3} }, 
		{"name":"evade","req":{"BT":2} } 
	]},
}

signal end_defiance_effect

func get_defiance(type):
	var def = DEFIANCES[type].duplicate(true)
	def["type"] = type
	def["node_ref"] = null
	return def

func get_random_defiance():
	randomize()
	var rk = DEFIANCES.keys()[ randi()%DEFIANCES.keys().size() ]
	return get_defiance(rk)

func get_room_random_defiances():
	var room_defiances = []
	randomize()
	for i in range(4): if randi()%100<40: room_defiances.append(get_random_defiance())
	return room_defiances

func on_click_action(action_data):
	if SlatsManager.consume_slats(action_data.req): 
		var metod_name = "ac_"+action_data.defiance_data.type+"_"+action_data.name
		if has_method(metod_name): call(metod_name,action_data)
	else: EffectManager.shake_rect(SlatsManager.SLATTER)

func on_resolve_defiance(defiance_data):
	var metod_name = "resolve_"+defiance_data.type
	if has_method(metod_name): 
		EffectManager.zoom_yoyo(defiance_data.node_ref)
		call(metod_name,defiance_data)
		yield(get_tree().create_timer(1.5),"timeout")
	yield(get_tree().create_timer(.2),"timeout")
	emit_signal("end_defiance_effect")

#ENEMY
func ac_enemy_attack(action_data):
	action_data.defiance_data.node_ref.reduce_defiance_level()
	EffectManager.shake(action_data.defiance_data.node_ref)

func resolve_enemy(defiance_data):
	EffectManager.shake(defiance_data.node_ref)
	PlayerManager.damage_player(defiance_data.damage)
	
