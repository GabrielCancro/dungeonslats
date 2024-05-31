extends Node

var GAME
var current_player_index = 0
var players = []

signal update_player_data(player_data)

func _initialize_player_manager(_GAME):
	GAME = _GAME
	#PLAYER_TOKENS_CONTAINER = GAME.get_node("PlayerTokens")
	#MapManager.connect("load_new_room",self,"set_player_tokens")
	init_players_data(3)
	set_current_player(current_player_index)
	yield(get_tree().create_timer(.2),"timeout")
	for player_data in players: 
		var room_data = MapGenerator.get_room_data(player_data.posX,player_data.posY)
		if room_data && room_data.node_ref: 
			player_data.token_ref.position = room_data.node_ref.position
			player_data.token_ref.position.x += 40*player_data.index

func init_players_data(amount):
	randomize()
	for i in range(amount):
		players.append({
			"index":i,
			"retrait":i+1,
			"hp":6,"hpm":6,
			"mv":3,"mvm":3,
			"feat":2,
			"posX":0,"posY":0,
			"items":[],
			"abilities":[],
			"slats":{"SW":randi()%5, "GR":randi()%5, "EY":randi()%5, "BT":randi()%5, "SC":randi()%5},
			"token_ref": preload("res://gameObjects/PlayerToken.tscn").instance()
		})
		ItemManager.add_ability_to_player("berserk",i)
		players[i].token_ref.set_data(players[i])
		GAME.get_node("Map").add_child(players[i].token_ref)

func get_player_data(index = current_player_index):
	return players[index]

func get_player_room_data():
	var player_data = get_player_data()
	return MapGenerator.get_room_data(player_data.posX,player_data.posY)

func player_data_inc(k,v):
	var player_data = get_player_data()
	player_data[k] += v
	if player_data[k]<0: 
		player_data[k] = 0
		emit_signal("update_player_data",player_data)
		return false
	if k+"m" in player_data: player_data[k] = min(player_data[k],player_data[k+"m"])
	emit_signal("update_player_data",player_data)
	return true

func player_data_set(k,v):
	var player_data = get_player_data()
	player_data[k] = v
	emit_signal("update_player_data",player_data)

#func get_player_token(index = current_player_index):
#	return PLAYER_TOKENS_CONTAINER.get_child(current_player_index)

func damage_player(dam=1):
	var player_data = get_player_data()
	player_data.hp -= 1
#	if dam>0: 
#		Effector.shake(get_player_token(),5)
#		Effector.damage_player()
	emit_signal("update_player_data",player_data)

func set_current_player(index):
	current_player_index = index
	get_player_data().token_ref.z_index = 1
	emit_signal("update_player_data",get_player_data())

func set_next_player():
	get_player_data().token_ref.z_index = 0
	current_player_index += 1
	if current_player_index >= players.size():
		current_player_index = 0
	set_current_player(current_player_index)

func move_player_to(dir):
	print(dir)
	if !PlayerManager.player_data_inc("mv",-1): return
	var pdata = get_player_data()
	pdata.posX += dir.x
	pdata.posY += dir.y
	pdata.token_ref.position = get_player_room_data().node_ref.position
	pdata.token_ref.position.x += 40*pdata.index
	focus_camera()
#	for pd in players:
#		if pdata!=pd && pd.posX==pdata.posX && pd.posX==pdata.posX:
#			pdata.token_ref.z_index = 0
#	

func focus_camera():
	GAME.get_node("Camera2D").position = get_player_room_data().node_ref.position

#func set_player_tokens(room_data):
#	for PT in PLAYER_TOKENS_CONTAINER.get_children():
#		if PT.get_index() >= players.size(): 
#			PT.visible = false
#			continue
#		else:
#			var pdata = players[PT.get_index()]
#			PT.get_node("Retrait/Image").texture = load("res://assets/retraits/token_retrait"+str(pdata.retrait)+".png")
#			PT.visible = false
#			if check_player_in_current_room(pdata):
#				PT.visible = true
#				if PT.get_index()!=current_player_index: 
#					PT.get_child(0).rect_scale = Vector2(.8,.8)
#					PT.modulate = Color(.6,.6,.6,1)
#				else: 
#					PT.get_child(0).rect_scale = Vector2(1,1)
#					PT.modulate = Color(1,1,1,1)
#
#
#func check_player_in_current_room(player_data):
#	return( player_data.posX == MapManager.get_current_room_data().posX
#		&& player_data.posY == MapManager.get_current_room_data().posY )
#
#func add_item_to_player(item_data):
#	var pdata = get_player_data()
#	for i in range(pdata.items.size()):
#		if pdata.items[i]==null:
#			pdata.items[i] = item_data
#			emit_signal("update_player_data",pdata)
#			return true
#	Effector.add_float_text("wr_many_items",.5,.75)
#	return false
