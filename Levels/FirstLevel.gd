extends Node2D

var playerTurn = true;
var cutscene = true;
onready var target = $Falling/Bounce/Player.global_position;
var pos = Vector2(0,0);
var playerMoving = false;
var dir = "";
#move to player
#var vol = Vector2();



func _ready():
	$Bounce.play("Bouncy");

func _input(event):
	if !cutscene and !playerMoving:
		#print(event.to_string());
		if event.is_action_pressed("click"):
			print("CLICK");
			#loop thru all the possible moves
			for hit in $Falling/Bounce/Player/PossibleMoves.get_children():
				#print($Falling/Bounce/Player/PossibleMoves.get_children());
				#check to see if mouse is in hitbox, then set the target location of movement to the position selected
				#print(hit.getRect())
				if hit.getRect().has_point(get_global_mouse_position()):
					pos = $Falling/Bounce/Player.global_position;
					print(pos);
					target = hit.global_position;
					#print(hit.get_name());
					dir = hit.get_name();
					#speed is porportioal to the distance
					$Falling/Bounce/Player.vol = pos.direction_to(target) * pos.distance_to(target);
					playerMoving = true;
					break;
		#target = get_global_mouse_position();
	

func _physics_process(delta):
	
	if playerMoving:
		if $Falling/Bounce/Player.global_position.distance_to(target) <= 5:
			$Falling/Bounce/Player.vol = Vector2(0,0);
			
			$Falling/Bounce/Player.global_position = target;
			#offset bc its gonna be off by 5 pixels
			#if dir == "Up":
				#$Falling/Bounce/Player.global_position.y -= $Falling/Bounce/Player.global_position.distance_to(target);
			
			#if dir == "Left":
				#$Falling/Bounce/Player.global_position.x -= $Falling/Bounce/Player.global_position.distance_to(target);
				
			#if dir == "Right":
				#$Falling/Bounce/Player.global_position.x += $Falling/Bounce/Player.global_position.distance_to(target);
			
			#if dir == "CaptureRight":
			#	var xOff = cos($Falling/Bounce/Player.global_position.distance_to(target));
			#	var yOff = sin($Falling/Bounce/Player.global_position.distance_to(target));
			#	$Falling/Bounce/Player.global_position.x += xOff;
			#	$Falling/Bounce/Player.global_position.y += yOff;
				
			#if dir == "CaptureLeft":
			#	var xOff = cos($Falling/Bounce/Player.global_position.distance_to(target));
			#	var yOff = sin($Falling/Bounce/Player.global_position.distance_to(target));
			#	$Falling/Bounce/Player.global_position.x -= $Falling/Bounce/Player.global_position.distance_to(target);
			#	$Falling/Bounce/Player.global_position.y -= $Falling/Bounce/Player.global_position.distance_to(target);
			playerMoving = false;
			playerTurn = false;
			#player velocity is 0 when near the target
	
	
func _on_Bounce_animation_finished(anim_name):
	cutscene = false;
	
