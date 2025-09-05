extends StaticBody2D

var blue = load("res://assets/blue.png")
var green = load("res://assets/green.png")
var orange = load("res://assets/orange.png")
var beige = load("res://assets/beige.png")
var brown = load("res://assets/brown.png")
var lightpurp = load("res://assets/lightpurp.png")
var lime = load("res://assets/lime.png")
var pink = load("res://assets/pink.png")
var purple = load("res://assets/purple.png")

var america = load("res://assets/buildings/america.png")
var capital = load("res://assets/buildings/capital.png")
var chase = load("res://assets/buildings/chase.png")
var chuck = load("res://assets/buildings/chuck.png")
var city = load("res://assets/buildings/city.png")
var fargo = load("res://assets/buildings/fargo.png")
var gold = load("res://assets/buildings/gold.png")
var mnt = load("res://assets/buildings/mnt.png")
var north = load("res://assets/buildings/north.png")
var std = load("res://assets/buildings/std.png")
var house = load("res://assets/buildings/house.png")
var oomf = load("res://assets/buildings/oomf.png")
var iseea = load("res://assets/buildings/iseea.png")
var seans = load("res://assets/buildings/seans.png")
var hgh = load("res://assets/buildings/hgh.png")
var sev = load("res://assets/buildings/sev.png")
var wawa = load("res://assets/buildings/wawa.png")
var drac = load("res://assets/buildings/drac.png")
var monte = load("res://assets/buildings/monte.png")
var kyle = load("res://assets/buildings/kyle.png")
var amish = load("res://assets/buildings/amish.png")
var peter = load("res://assets/buildings/peter.png")

var colors = [america,capital,chase,chuck,city,fargo,gold,mnt,north,std,house,oomf,iseea,seans,
hgh,sev,wawa,drac,monte,kyle,amish,peter]

# Called when the node enters the scene tree for the first time.
func _ready():
	$"."/Sprite2D.texture = colors[randi_range(0,len(colors)-1)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(Global.get_global_speed() != 0):
		$".".position.y += Global.get_global_speed()

func _on_detect_collisions_body_entered(body):
	if body is CharacterBody2D:
		Global.set_global_speed(0)
		
func _on_detect_collisions_body_exited(body):
	if body is CharacterBody2D:
		Global.set_global_speed(2)
