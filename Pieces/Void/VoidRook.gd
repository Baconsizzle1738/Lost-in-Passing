extends KinematicBody2D

var inScreen = false;
var target = Vector2(0,0);
var moving = false;
var vol = Vector2(0,0);


func _ready():
	pass # Replace with function body.

func _process(delta):
	if moving:
		move_and_slide(vol);
	if global_position.distance_to(target) < 16:
		global_position = target;
		vol = Vector2(0,0);
		moving = false;
		get_parent().get_parent().playerTurn = true;
		get_parent().get_parent().enemyMoving = false;


func getRandomMove():
	return $moves.get_children()[randi()%($moves.get_children().size()-1)];

func canSeePlayer():
	for move in $moves.get_children():
		if move.is_colliding():
			return true;
	return false;

func playerPos():
	if canSeePlayer():
		for move in $moves.get_children():
			if move.is_colliding():
				return move.get_collider().global_position;

func _on_VisibilityEnabler2D_screen_entered():
	inScreen = true;



func _on_VisibilityEnabler2D_screen_exited():
	inScreen = false;
