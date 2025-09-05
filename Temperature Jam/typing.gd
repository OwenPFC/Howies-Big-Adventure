extends Node2D

signal perfect_segment()
signal incorrect_letter()
signal correct_letter()

var cover = load("res://assets/text_assets/howie_cover.png")
var howie = load("res://assets/text_assets/howie.png")

var g1 = preload("res://assets/sounds/389804__krnash__shattering-glass.wav")
var g2 = preload("res://assets/sounds/330800__czarcazas__shattering-glass-small.mp3")
var g3 = preload("res://assets/sounds/459116__mabdurrahman__gun-shot-1.wav")

var sounds = [g1,g2,g3]

signal win

#sc stands for speech chunk!!!!!!!!!!!!!!!!!!!!!!!!!!!
var sc1:String = "Back in my youth, it was commonplace to purchase a carton of milk, and with much certainty, you could stroll to wherever you were headed with the sanctity of mind that your milk would not get too warm during your travels"
var sc2:String = "These days, seemingly inexplicably, the once temperate summers of Upstate New York that I used to know became blisteringly hot droughts that provide no safe haven for the sensitive dairy products I carry with me"
var sc3:String = "More than the sanctity for our perishables, it seems we've also lost all semblance of transitionary seasons"
var sc4:String = "It seems only a few weeks ago that we were deep in the throes of winter, and now I can hardly stand to be outside for the complete opposite reason; regardless of whether or not I have precious cargo on me"
var sc5:String = "I miss those mellow seasons, besides beautiful, temperate weather and the freedom to be whoever you want to when you go outside, Spring and Autumn always made me genuflect at the capabilities of our homeostatic nature, how quickly we're able to stabilize in any environment"
var sc6:String = "A glorious 50 degree day in March is practically freezing in October. A breezy 70 in September is blistering in May"

var sc7:String = "One aspect of this that I am ceaselessly amazed by is how no matter how hot I get while trying to fall asleep, I always wake up at the perfect temperature"
var sc8:String = "Even though one would think that the more time you spend under a blanket, the more heat that would accumulate, and the hotter you would get. But I always wake up neither warm nor cool, just in perfect balance"
var sc9:String = "This is a feature of our bodies that I find to be fundamental to the human experience. Unconsciously, we adapt to any situation, we optimize against the next hardship. Quite naturally, we become good at things simply by doing them"
var sc10:String = "Look at the kids of today. They're whizzes on their devices, they can type faster than I ever could in my glory days, and I was quite the typist: I often outpaced my own secretary"
var sc11:String = "I was a man taking my own memos in the 80s, quite progressive for the time. But to get that skill, I had to take some typing classes at a local community college: I was too young to have had typing class in school, but I always knew that it would be a necessary skill for any self respecting business man, and so I took the task quite seriously"
var sc12:String = "I don't believe the kids of today even see typing as a skill to be learned, it's simply a thing they can do, a  physical process as natural as crawling. It's been in their environment all of their lives, there's no need for formal training"
var sc13:String = "I wonder, are you at home typing with the home row right now? I highly doubt it. Almost certainly you're thoughtlessly typing, with a technique you've developed and perfected over years of usage without ever thinking about it a single time. And you type with more proficiency than I could ever dream of"

var sc14:String = "I say all of this because a question my friend posed to me has been on my mind recently. While bowling, she asked me if I thought someone could passively increase their bowling skills just by playing, paying no mind to their technique"
var sc15:String = "While I see the reasoning for thinking it not possible, I think the reasoning I've presented above is quite sufficient to prove my point and I don't think it's necessary to repeat. I don't think bowling is any different than typing, or playing an instrument, or biking, or how we perceive our own voices"
var sc16:String = "As far as I'm concerned, my voice has sounded exactly the same my whole life. I was recently shown some home videos from when I was around 13 years old, needless to say that I don't remember it happening that way"
var sc17:String = "All of these things improve at around the same rate at which the hair on our head grows"
var sc18:String = "It's imperceptible for us to see: game by game our scores will be about the same, day by day my voice sounds the same, my hair looks the same, but give it a few weeks, and seemingly by no will of my own my hair is longer, my voice is deeper, and my bowling average has increased by 15 points"

var sc19:String = "Speaking of bowling, you ever notice how greasy the bowling balls are? The ones at the lanes are uncared for, and all of the oil from the floor accumulates on the balls"
var sc20:String = "A man of my stature should have his own bowling ball, to me that's always been a status symbol of being a man. I'm hesitant to buy one for myself though"
var sc21:String = "When I was a kid, a bowling ball was a gift a wife gave to her husband, or a son bought for his father. I always figured I'd be given one one day"
var sc22:String = "In fact, waking up on Christmas and seeing that spherical gift under the tree, wrapped delicately by the woman I love, this was always an image I pictured for my future"
var sc23:String = "Unfortunately, by the time I got married, the bowling ball had become an antiquated gift, and the act of giving one was seen as passe and impersonal, unless the recipient was a known bowler"
var sc24:String = "As nothing but a hobbyist, it seems that it's upon me to buy one for myself, but I'm not sure I'm ready yet"
var sc25:String = "As long as I still believe that one day my wife, my daughter, or my son will gift me one, that means I still have lots of time to grow up and become the man I've always dreamt of being"

var scEND:String = "Big winner man"

var sc26:String = "And here's my building, another successful walk with my milk kept at a safe temperature. I'll now head into the lobby, get on the escalator, and enjoy the rest of my 1 hour paid lunch break. "
var sc27:String = "Cheers"



var speechSegments = [sc1,sc2,sc3,sc4,sc5,sc6,sc7,sc8,sc9,sc10,sc11,sc12,sc13,sc14,sc15,sc16,sc17,sc18,sc19,
sc20,sc21,sc22,sc23,sc23,sc24,sc25, scEND]
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
	textToType = speechSegments[0]
	nextChunk(textToType)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if textToType == scEND:
		win.emit()

	if(Global.get_global_speed() == 0):
		$".".visible = false
	else:
		$".".visible = true
	
	#Load this in by having an index for all segments in the array, call this with index+1
func nextChunk(segment:String):
	var redFound = false
	for key in segment_dict:
		if(segment_dict[key].find("red") != -1):
			redFound = true
	if !redFound:
		perfect_segment.emit()
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
	if( letter != textToType[letterIndex] and letter == textToType[letterIndex].to_upper()):
		letter = textToType[letterIndex]
	if(len(letter)>1):
		letter = letter.substr(6)
	if(letter == textToType[letterIndex]):
		segment_dict[letterIndex] = "[color=blue]" + letter + "[/color]"
		correct_letter.emit()
	else:
		segment_dict[letterIndex] = "[color=red]" + letter + "[/color]"
		$sounds.stream = sounds[randi_range(0,2)]
		$sounds.play()
		incorrect_letter.emit()
	
	updateTextbox()
	
#called in color letter to update the textbox
func updateTextbox():
	var output = ""
	for key in segment_dict:
		output+=segment_dict.get(key,"INDEX_ERROR")
	$text_to_type.text = output
	
func _unhandled_input(event):
	if $".".visible and event is InputEventKey and (event.is_action_pressed("Type", false, false)||event.is_action_pressed("Type_More", false, false)):
		letterToType = event.as_text_keycode().to_lower()
		if(len(letterToType)>1):
			letterToType = event.as_text_keycode().to_upper()
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
			
			
			
