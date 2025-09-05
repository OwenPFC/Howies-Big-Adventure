extends Node2D

var cover = load("res://assets/text_assets/howie_cover.png")
var howie = load("res://assets/text_assets/howie.png")

var song = preload("res://assets/sounds/allegro.mp3")

#sc stands for speech chunk!!!!!!!!!!!!!!!!!!!!!!!!!!!
var sc1:String = "Type what you see!"
var sc2:String = "This is Howie"
var sc3:String = "He's just purchased some milk on his 1 hour paid lunch break and is now walking back to his office on this hot summer day"
var sc4:String = "Howie is very lost in thought, you must help him think his thoughts while keeping him and his milk nice and cool on his walk"
var sc5:String = "If you mess up his train of thought, he'll get flustered and heat up. Make it to the end of his monologue to have a successful walk"
var sc55 = "Howie will die at about 110 F, and the milk will spoil at about 40 F"
var sc6:String = "You can also move left and right with the arrow keys :) STAY IN THE SHADE"

var sc7:String = "Change to level"

var speechSegments = [sc1,sc2,sc3,sc4,sc5,sc55,sc6,sc7]
var speechChunkNumber = 0
#The active speech chunk
var textToType:String
var letterToType:String

var letterIndex:int = 0
#This is used to track and change the colors of the letters in each segment
var segment_dict:Dictionary
#this gathers all of the letters typed, to verify at the end if it matches the active speech chunk
var textAccumulation:String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$music.stream = song
	$music.play()
	
	$howie_intro.texture = cover
	textToType = speechSegments[0]
	nextChunk(textToType)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(textToType == sc2):
		print("2")
		$howie_intro.texture = howie
	if(textToType == sc7):
		print("7")
		get_tree().change_scene_to_file("res://level.tscn")
	
	#Load this in by having an index for all segments in the array, call this with index+1
func nextChunk(segment:String):
	var redFound = false
	for key in segment_dict:
		if(segment_dict[key].find("red") != -1):
			redFound = true
	#There's more, but I just wanted to establish this for now
	textToType = segment
	$text_to_type.text = segment
	
	letterIndex = 0
	segment_dict = {}
	var segmentIndex = 0
	while segmentIndex < len(segment):
		for letter in segment:
			segment_dict[segmentIndex] = segment[segmentIndex]
		segmentIndex+=1

func colorLetter(letter:String):
	print(textToType[letterIndex])
	print(letter)
	if( letter != textToType[letterIndex] and letter == textToType[letterIndex].to_upper()):
		letter = textToType[letterIndex]
	if(len(letter)>1):
		letter = letter.substr(6)
	if(letter == textToType[letterIndex]):
		segment_dict[letterIndex] = "[color=blue]" + letter + "[/color]"
	else:
		segment_dict[letterIndex] = "[color=red]" + letter + "[/color]"
	
	updateTextbox()
	
#called in color letter to update the textbox
func updateTextbox():
	var output = ""
	for key in segment_dict:
		output+=segment_dict.get(key,"INDEX_ERROR")
	print(output)
	$text_to_type.text = output
	
func _unhandled_input(event):
	if $".".visible and event is InputEventKey and (event.is_action_pressed("Type", false, false)||event.is_action_pressed("Type_More", false, false)):
		letterToType = event.as_text_keycode().to_lower()
		if(len(letterToType)>1):
			letterToType = event.as_text_keycode().to_upper()
		print(letterToType)
		if(letterToType == "SPACE" || letterToType == "SHIFT+SPACE"):
			letterToType = " "
		elif(letterToType == "APOSTROPHE"):
			letterToType = "'"
		elif(letterToType == "QUOTELEFT"):
			letterToType = "`"
		elif(letterToType == "MINUS"):
			letterToType = "-"
		elif(letterToType == "EQUAL"):
			letterToType = "="
		if(letterToType == "SHIFT+1"):
			letterToType = "!"
		elif(letterToType == "SHIFT+2"):
			letterToType = "@"
		elif(letterToType == "SHIFT+3"):
			letterToType = "#"
		elif(letterToType == "SHIFT+4"):
			letterToType = "$"
		elif(letterToType == "SHIFT+5"):
			letterToType = "%"
		elif(letterToType == "SHIFT+6"):
			letterToType = "^"
		elif(letterToType == "SHIFT+7"):
			letterToType = "&"
		elif(letterToType == "SHIFT+8"):
			letterToType = "*"
		elif(letterToType == "SHIFT+9"):
			letterToType = "("
		elif(letterToType == "SHIFT+0"):
			letterToType = ")"
		elif(letterToType == "BRACKETLEFT"):
			letterToType = "["
		elif(letterToType == "BRACKETRIGHT"):
			letterToType = "]"
		elif(letterToType == "BACKSLASH"):
			letterToType = "\\"
		elif(letterToType == "SEMICOLON"):
			letterToType = ";"
		elif(letterToType == "COMMA"):
			letterToType = ","
		elif(letterToType == "PERIOD"):
			letterToType = "."
		elif(letterToType == "SLASH"):
			letterToType = "/"
		elif(letterToType == "SHIFT+APOSTROPHE"):
			letterToType = '"'
		elif(letterToType == "SHIFT+QUOTELEFT"):
			letterToType = "~"
		elif(letterToType == "SHIFT+MINUS"):
			letterToType = "_"
		elif(letterToType == "SHIFT+EQUAL"):
			letterToType = "+"
		elif(letterToType == "SHIFT+BRACKETLEFT"):
			letterToType = "{"
		elif(letterToType == "SHIFT+BRACKETRIGHT"):
			letterToType = "}"
		elif(letterToType == "SHIFT+BACKSLASH"):
			letterToType = "|"
		elif(letterToType == "SHIFT+SEMICOLON"):
			letterToType = ":"
		elif(letterToType == "SHIFT+COMMA"):
			letterToType = "<"
		elif(letterToType == "SHIFT+PERIOD"):
			letterToType = ">"
		elif(letterToType == "SHIFT+SLASH"):
			letterToType = "?"
		
		colorLetter(letterToType)
		
		letterIndex+=1
		
		if letterIndex == len(textToType):
			speechChunkNumber+=1
			nextChunk(speechSegments[speechChunkNumber])
			
			
			
