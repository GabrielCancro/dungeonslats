extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerManager.connect("update_player_data",self,"update_sheet")

func update_sheet(pdata): 
	if pdata != PlayerManager.get_player_data(): return
	$Label.text = "Player "+str(PlayerManager.current_player_index)
	$Label.text += "\nHP "+str(pdata.hp)+"/"+str(pdata.hpm)
	$Label.text += "\nMV "+str(pdata.mv)+"/"+str(pdata.mvm)
	$Label.text += "\nFEAT "+str(pdata.feat)
	update_slats(pdata)

func update_slats(pdata):
	var i = 0
	for k in SlatsManager.SLAT_COLORS.keys():
		$HBoxSlats.get_child(i).texture = load("res://assets/slats/"+k+".png")
		var node = $HBoxSlats.get_child(i)
		if k in pdata.slats && pdata.slats[k]>0: 
			node.modulate = Color(1,1,1,1)
			node.get_node("Label").text = str(pdata.slats[k])
		else: 
			node.modulate = Color(.3,.3,.3,1)
			node.get_node("Label").text = "x"
		i+=1
	
