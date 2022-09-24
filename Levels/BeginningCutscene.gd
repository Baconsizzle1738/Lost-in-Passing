extends Node2D



func _ready():
	#fserfrs
	#print("YEE");
	#$PlayMoves.stop(true);
	$PlayMoves.play("OpeningScene");


func _on_PlayMoves_animation_finished(anim_name):
	#change scene to first level
	get_tree().change_scene("res://Levels/FirstLevel.tscn");
	pass # Replace with function body.
