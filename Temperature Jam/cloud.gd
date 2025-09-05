extends AnimatableBody2D

var cloud1 = load("res://assets/clouds/c1.png")
var cloud2 = load("res://assets/clouds/c2.png")
var cloud4 = load("res://assets/clouds/c4.png")
var cloud5 = load("res://assets/clouds/c5.png")

var clouds = [cloud1,cloud2, cloud4,cloud5]
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$"."/Sprite2D.texture = clouds[randi_range(0,len(clouds)-1)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(global_position.x < 1300):
		$"."/hitbox.disabled = true
	else:
		$"."/hitbox.disabled = false
	
	$".".position.x += 1

