extends Control

var type
var isValid = false

func set_slat(_type):
	type = _type
	$TextureRect.texture = load("res://assets/slats/"+type+".png")

func _ready():
	rect_global_position = get_viewport_rect().size/2
	roll()

func roll():
	randomize()
	isValid = (randi()%100<50)
	print(isValid)
	if isValid: modulate = SlatsManager.get_color(type)
	else: modulate = Color(.4,.4,.4,0)
	var slow = randf()*0.2
	$Tween.interpolate_property(self,"modulate:a",0,1,.4+slow,Tween.TRANS_QUAD,Tween.EASE_OUT)
	var end_pos = get_viewport_rect().size/2 + Vector2(rand_range(-100,100),rand_range(-100,100))
	$Tween.interpolate_property(self,"rect_global_position",rect_global_position,end_pos,.3+slow,Tween.TRANS_QUAD,Tween.EASE_OUT)
	
	$Tween.start()

func goto_pos(end_pos):
	$Tween.interpolate_property(self,"rect_global_position",rect_global_position,end_pos,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()

func consume():
	isValid = false
	$Tween.interpolate_property(self,"rect_global_position",rect_global_position,rect_global_position+Vector2(0,-100),.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property(self,"modulate:a",1,0,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	get_parent().remove_child(self)
	queue_free()
