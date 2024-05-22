extends Control

var type
var isValid = false

func set_slat(_type):
	type = _type
	$TextureRect.texture = load("res://assets/dices/"+type+".png")

func _ready():
	roll()

func roll():
	randomize()
	isValid = (randi()%100<50)
	print(isValid)
	if isValid: modulate = Color(1,1,1,0)
	else: modulate = Color(.4,.4,.4,0)
	var slow = randf()*0.2
	$Tween.interpolate_property(self,"modulate:a",0,1,.4+slow,Tween.TRANS_QUAD,Tween.EASE_OUT)
	
	var start_pos = get_viewport_rect().size/2
	var end_pos = start_pos + Vector2(rand_range(-100,100),rand_range(-100,100))
	$Tween.interpolate_property(self,"rect_global_position",start_pos,end_pos,.3+slow,Tween.TRANS_QUAD,Tween.EASE_OUT)
	
	$Tween.start()

func goto_file(index):
	var end_pos = get_viewport_rect().size * Vector2(.5,.8)
	if isValid: end_pos.x -= 200
	else: end_pos.x += 200
	end_pos.x += index*20
	$Tween.interpolate_property(self,"rect_global_position",rect_global_position,end_pos,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
