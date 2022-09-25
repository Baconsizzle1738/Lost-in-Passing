extends KinematicBody2D

var vol = Vector2();
var canCaptureRight = true;
var canCaptureLeft = true;
var canLeft = true;
var canRight = true;
var canUp = true;
var piss = false;
var enemies = ["Pawn", "Knight", "Bishop", "Rook", "Queen"];

#loop thru enemies
func isEnemy(name):
	for e in enemies:
		if e == name:
			return true;
	return false;

func canGoHere(dir):
	if dir == "Up":
		return canUp;
	if dir == "Left":
		return canLeft;
	if dir == "Right":
		return canRight;
	if dir == "CaptureLeft":
		return canCaptureLeft;
	if dir == "CaptureRight":
		return canCaptureRight;

# Called when the node enters the scene tree for the first time.
func _ready():
	#global_position = Vector2(480, 416);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if piss:
		global_position = Vector2(480, 416);
		piss = false;
	#print($PossibleMoves/Left.get_overlapping_bodies());
	if $PossibleMoves/Right.get_overlapping_bodies().size() > 0:
		canRight = false;
	else:
		canRight = true;
		
	if $PossibleMoves/Left.get_overlapping_bodies().size() > 0:
		canLeft = false;
	else:
		canLeft = true;
		#print("LEFT TRUE AGIN")
	if $PossibleMoves/Up.get_overlapping_bodies().size() > 0:
		canUp = false;
	else:
		canUp = true;
	if $PossibleMoves/CaptureLeft.get_overlapping_bodies().size() > 0:
		canCaptureLeft = false;
	else:
		canCaptureLeft = true;
	if $PossibleMoves/CaptureRight.get_overlapping_bodies().size() > 0:
		canCaptureRight = false;
	else:
		canCaptureRight = true;
	
	#print(global_position);
	#if $CheckLeft.get_overlapping_areas().size() > 0:
	#	for area in $CheckLeft.get_overlapping_areas():
	#		print($CheckLeft.get_overlapping_areas())
	#		if isEnemy(area.get_parent().get_parent().get_name()):
	#			canCaptureLeft = true;
	#			break;
	#			#exit loop if true
	#		else:
	#			canCaptureLeft = false;
	
	#if$CheckRight.get_overlapping_areas().size() > 0:
	#	for area in $CheckRight.get_overlapping_areas():
	#		if isEnemy(area.get_parent().get_parent().get_name()):
	#			canCaptureRight = true;
	#			break;
	#			#exit loop of true
	#		else:
	#			canCaptureRight = false;
	
	move_and_slide(vol);
