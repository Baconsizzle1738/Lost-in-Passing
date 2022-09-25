extends Node2D

var playerTurn = true;
var cutscene = true;
onready var target = Vector2(0,0);
var pos = Vector2(0,0);
var playerMoving = false;
var dir = "";
var deez = false;

const PLAYER = preload("res://Pieces/Entities/PlayerPawn.tscn");
#move to player
#var vol = Vector2();



func _ready():
	$Bounce.play("Bouncy");

func _input(event):
	
	if !cutscene and !playerMoving:
		#print(event.to_string());
		if event.is_action_pressed("click"):
			$Player.piss = false;
			deez = false;
			print("CLICK");
			#loop thru all the possible moves
			for hit in $Player/PossibleMoves.get_children():
				#print($Falling/Bounce/Player/PossibleMoves.get_children());
				#check to see if mouse is in hitbox, then set the target location of movement to the position selected
				#print(hit.getRect())
				if hit.getRect().has_point(get_global_mouse_position()):
					dir = hit.get_name();
					#if dir == "CaptureLeft" and $Player.canCaptureLeft or dir == "CaptureRight" and $Player.canCaptureRight:
					pos = $Player.global_position;
					print(pos);
					target = hit.global_position;
					#print(hit.get_name());
					dir = hit.get_name();
					#speed is porportioal to the distance
					$Player.vol = pos.direction_to(target) * pos.distance_to(target)/0.5;
					playerMoving = true;
					break;
					#elif dir != "CaptureLeft" and dir != "CaptureRight":
					#	pos = $Player.global_position;
					#	print(pos);
					#	target = hit.global_position;
					#	#print(hit.get_name());
					##	dir = hit.get_name();
					#	#speed is porportioal to the distance
					#	$Player.vol = pos.direction_to(target) * pos.distance_to(target)/0.5;
					#	playerMoving = true;
					#	break;
					
		#target = get_global_mouse_position();


func _physics_process(delta):
	if deez:
		$Player.piss = true;
	
	if playerMoving and playerTurn:
		if $Player.global_position.distance_to(target) <= 3:
			$Player.vol = Vector2(0,0);
			
			$Player.global_position = target;
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
	
	$Falling/Bounce/Player.queue_free();
	var player = PLAYER.instance();
	player.global_position.x = 480;
	player.global_position.y = 416;
	player.name = "Player";
	player.piss = true;
	add_child(player);
	player.piss = true;
	deez = true;
	
	cutscene = false;
