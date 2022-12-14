extends Node2D

var playerTurn = true;
var cutscene = true;
onready var target = Vector2(0,0);
var pos = Vector2(0,0);
var playerMoving = false;
var dir = "";
var deez = false;
var killing = false;
var enemyMoving = false;
const MOVEBOX = preload("res://Pieces/Entities/MoveBox.tscn");
var moveboxes = ["goRight", "goLeft", "goUp", "goCaptureLeft", "goCaptureRight"];
var displayMoves = false;
const PLAYER = preload("res://Pieces/Entities/PlayerPawn.tscn");

#move to player
#var vol = Vector2();



func _ready():
	$Bounce.play("Bouncy");

func _input(event):
	
	if !cutscene and !playerMoving and playerTurn:
		#print(event.to_string());
		if event.is_action_pressed("click"):
			$Player.piss = false;
			deez = false;
			#print("CLICK");
			#loop thru all the possible moves
			for hit in $Player/PossibleMoves.get_children():
				#print($Falling/Bounce/Player/PossibleMoves.get_children());
				#check to see if mouse is in hitbox, then set the target location of movement to the position selected
				#print(hit.getRect())
				if hit.get_children()[0].getRect().has_point(get_global_mouse_position()):
					dir = hit.get_name();
					print($Player.canGoHere(dir))
					if $Player.canGoHere(dir):
						unDisplayMoves();
						#if dir == "CaptureLeft" and $Player.canCaptureLeft or dir == "CaptureRight" and $Player.canCaptureRight:
						pos = $Player.global_position;
						#print(pos);
						target = hit.get_children()[0].global_position;
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

func displayMoves():
	for hit in $Player/PossibleMoves.get_children():
		var name = hit.get_name();
		if $Player.canGoHere(name):
			var box = MOVEBOX.instance();
			box.global_position = hit.get_children()[0].global_position;
			box.name = "go" + hit.name;
			add_child(box);
			displayMoves = true;

func unDisplayMoves():
	for thing in get_children():
		for name in moveboxes:
			if name == thing.name:
				thing.queue_free();
	displayMoves = false;

func _physics_process(delta):
	if deez:
		$Player.piss = true;
	
	if !displayMoves and playerTurn and !playerMoving and !cutscene:
		displayMoves();
	
	if playerMoving:
		#if player goes within a threshold then 
		if $Player.global_position.distance_to(target) <= 4:
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
	if !playerMoving and !playerTurn and !cutscene and !enemyMoving:
		#check if any enemies can see the player
		#if they do they go to player
		for enemy in $enemies.get_children():
			var epos = enemy.global_position;
			if enemy.inScreen:
				if enemy.canSeePlayer():
					enemy.target = $Player.global_position;
					killing = true;
					enemy.moving = true;
					enemy.vol = epos.direction_to(target) * epos.distance_to(target)/0.5;
					enemyMoving = true;
				
				#no enemies see player, 1 in 10 chance to move somewhere random
				else:
					var random = randi()%10;
					if random == 1:
						
						enemy.target = enemy.getRandomMove().get_cast_to() + enemy.global_position;
						#print (enemy.name, epos, enemy.target)
						enemy.moving = true;
						enemy.vol = epos.direction_to(enemy.target) * epos.distance_to(enemy.target)/0.5;
						print(enemy.name, epos, enemy.target, epos.direction_to(target), epos.distance_to(target)/0.5)
						enemyMoving = true;
	
	
	if !cutscene:
		#promotions first, then death.
		for promo in $promotionSquares.get_children():
			#a promo is one promotion square object
			for thing in promo.getArea().get_overlapping_areas():
				print(thing.name);
				if thing.name == "PlayerHitbox":
					get_tree().change_scene("res://Levels/Win.tscn");
			
		
		if $Player/PlayerHitbox.get_overlapping_areas().size() > 0:
			if $Player/PlayerHitbox.get_overlapping_areas()[0].name != "Promote":
				get_tree().change_scene("res://Levels/death.tscn");
			
		
		





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
