extends Control

var type = "SW"
var amount = 3
var is_complete = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.texture = load("res://assets/slats/"+type+".png")
	$TextureRect.modulate = SlatsManager.get_color(type)
	$Button.connect("button_down",self,"on_click")
	update()

func update():
	$Label.text = str(amount)
	if amount==0: 
		is_complete = true
		$Label.visible = false
		modulate = Color(1,1,.5,1)

func on_click():
	if is_complete: return
	if SlatsManager.assign_slat(type):
		amount -= 1
		update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
