extends CollisionShape2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getRect():
	return Rect2(global_position.x-12.5, global_position.y-12.5, 25, 25);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
