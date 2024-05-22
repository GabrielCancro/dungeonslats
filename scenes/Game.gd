extends Node2D

var vel = 10
var room_size = Vector2(200,150)

# Called when the node enters the scene tree for the first time.
func _ready():
	SlatsManager._init_slat_manager(self)
	MapGenerator.generate_new_map(30,false)
	for room_name in MapGenerator.rooms:
		var room_data = MapGenerator.rooms[room_name]
		var rnode = load("res://gameObjects/Room.tscn").instance()
		rnode.set_data(room_data)
		rnode.scale *= 0.5
		rnode.position = Vector2(room_data.posX,room_data.posY)*room_size
		$Map.add_child(rnode)
	
	for door_data in MapGenerator.doors:
		print(door_data)
		var dnode = load("res://gameObjects/Door.tscn").instance()
		dnode.scale *= 0.5
		var pos = door_data.tileA + (door_data.tileB - door_data.tileA)/2
		dnode.position = pos*room_size
		$Map.add_child(dnode)

func _process(delta):
	if Input.is_action_pressed("ui_up"): $Map.position.y += vel
	if Input.is_action_pressed("ui_down"): $Map.position.y -= vel
	if Input.is_action_pressed("ui_left"): $Map.position.x += vel
	if Input.is_action_pressed("ui_right"): $Map.position.x -= vel

