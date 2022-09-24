extends Node2D

var playerTurn = true;

func _ready():
	$Bounce.play("Bouncy");

func _physics_process(delta):
	pass

func _on_Bounce_animation_finished(anim_name):
	pass # Replace with function body.
	
