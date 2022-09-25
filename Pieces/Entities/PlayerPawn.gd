extends KinematicBody2D

var vol = Vector2();
var canCaptureRight = false;
var canCaptureLeft = false;
var piss = false;
var enemies = ["Pawn", "Knight", "Bishop", "Rook", "Queen"];

#loop thru enemies
func isEnemy(name):
	for e in enemies:
		if e == name:
			return true;
	return false;



# Called when the node enters the scene tree for the first time.
func _ready():
	#global_position = Vector2(480, 416);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if piss:
		global_position = Vector2(480, 416);
		piss = false;
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
