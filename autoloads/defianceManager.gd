extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_click_action(action_data):
	if SlatsManager.consume_slats(action_data.req): 
		var metod_name = "ac_"+action_data.defiance_data.type+"_"+action_data.name
		if has_method(metod_name): call(metod_name,action_data)
	else: EffectManager.shake_rect(SlatsManager.SLATTER)

func ac_enemy_attack(action_data):
	print("CALL AN ACTION FUNCTION --> ac_enemy_attack")
	EffectManager.shake(action_data.defiance_data.node_ref)
