extends Node2D

var temperature:float = 51.8 #Offsetting the initial cooloff, so he starts at 37
var milkTemp:float = 6.5

signal fail(which:String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$celsius.text = str(snapped(temperature,0.001)) + " C"
	var f = (temperature * (9.0/5.0)) + 32
	$fahrenheit.text = str(snapped(f,0.001)) + " F"
	$celsius2.text = str(snapped(milkTemp,0.001)) + " C"
	
	var f2 = (milkTemp * (9.0/5.0)) + 32
	$fahrenheit2.text = str(snapped(f2,0.001)) + " F"
	
	if(f>110):
		fail.emit("Howie")
	if(f2>40):
		fail.emit("Milk")


func _on_howie_increase_temp(power):
	temperature += power
	milkTemp += power * 0.4

func _on_howie_decrease_temp(power):
	#print("cooling")
	if(milkTemp>0 or temperature>35):
		temperature -= power*5
		milkTemp -= power*1.8
