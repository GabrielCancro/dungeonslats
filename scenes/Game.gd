extends Node2D

var vel = 10
var room_size = Vector2(520+32,368)

# Called when the node enters the scene tree for the first time.
func _ready():
	SlatsManager._init_slat_manager(self)
	MapGenerator.generate_new_map(30,false)
	for room_name in MapGenerator.rooms:
		var room_data = MapGenerator.rooms[room_name]
		var rnode = preload("res://gameObjects/Room.tscn").instance()
		rnode.set_data(room_data)
		rnode.position = Vector2(room_data.posX,room_data.posY)*room_size
		$Map.add_child(rnode)
	
	for door_data in MapGenerator.doors:
		#print(door_data)
		var dnode = preload("res://gameObjects/Door.tscn").instance()
		var pos = door_data.tileA + (door_data.tileB - door_data.tileA)/2
		dnode.position = pos*room_size
		dnode.set_data(door_data)
		$Map.add_child(dnode)

func _process(delta):
	if Input.is_action_pressed("ui_up"): $Camera2D.position.y -= vel
	if Input.is_action_pressed("ui_down"): $Camera2D.position.y += vel
	if Input.is_action_pressed("ui_left"): $Camera2D.position.x -= vel
	if Input.is_action_pressed("ui_right"): $Camera2D.position.x += vel
	if Input.is_action_just_pressed("ui_zoom_in"): 
		$Camera2D.zoom *= .9
		print("ZOOM ",$Camera2D.zoom.x)
	if Input.is_action_just_pressed("ui_zoom_out"): 
		$Camera2D.zoom *= 1.1
		print("ZOOM ",$Camera2D.zoom.x)

