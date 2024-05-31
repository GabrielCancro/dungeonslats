extends Node

var ABILITIES = {
	"berserk":{"max_uses":3}
}

func get_ability(code_ab):
	var ab = ABILITIES[code_ab].duplicate()
	ab["name"] = code_ab
	return ab

func add_ability_to_player(code_ab,index=PlayerManager.current_player_index):
	var pdata = PlayerManager.get_player_data(index)
	pdata.abilities.append(get_ability(code_ab))

func on_use_berserk():
	print("USE ABILITY BERSERK")
