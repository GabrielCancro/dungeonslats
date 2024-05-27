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

func get_defiance(type):
	var def = DEFIANCES[type].duplicate(true)
	def["type"] = type
	def["node_ref"] = null
	return def

func get_random_defiance():
	randomize()
	var rk = DEFIANCES.keys()[ randi()%DEFIANCES.keys().size() ]
	return get_defiance(rk)

func on_click_action(action_data):
	if SlatsManager.consume_slats(action_data.req): 
		var metod_name = "ac_"+action_data.defiance_data.type+"_"+action_data.name
		if has_method(metod_name): call(metod_name,action_data)
	else: EffectManager.shake_rect(SlatsManager.SLATTER)

func ac_enemy_attack(action_data):
	action_data.defiance_data.node_ref.reduce_defiance_level()
	print("CALL AN ACTION FUNCTION --> ac_enemy_attack")
	EffectManager.shake(action_data.defiance_data.node_ref)
