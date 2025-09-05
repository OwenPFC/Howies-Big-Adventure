extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func increase_rote_c(temp):
	$CTemp/Arrow.rotation+=temp
	$CTempMilk/Arrow.rotation+=temp*3.7
	
func increase_rote_f(temp):
	$FTemp/Arrow.rotation+=temp
	$FTempMilk/Arrow.rotation+=temp
	
func decrease_rote_c(temp):
	$CTemp/Arrow.rotation-=temp
	$CTempMilk/Arrow.rotation-=temp*4
	
func decrease_rote_f(temp):
	$FTemp/Arrow.rotation-=temp*10
	$FTempMilk/Arrow.rotation-=temp*10
