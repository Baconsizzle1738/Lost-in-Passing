extends Node2D

export (String) var path = "res://";
export (String) var fileName = "CorruptTiles";
export (String) var animation = "spazzing";
export (bool) var collision = true;
export (int) var columns = 6;

var currColumn := 0;
var pos := Vector2();

func _ready():
	var tileSet := TileSet.new();
	
	for frame in $Tiles.frames.get_frame_count(animation):
		var texture : Texture = $Tiles.frames.get_frame(animation, frame);
		var sprite := Sprite.new();
		sprite.texture = texture;
		add_child(sprite);
		var size := texture.get_size();
		sprite.global_position += pos + size * 0.5;
		pos.x += size.x;
		
		currColumn += 1;
		if currColumn >= columns:
			currColumn = 0;
			pos.x = 0;
			pos.y = size.y;
			
		addToTileSet(tileSet, sprite);
		
	
	
	ResourceSaver.save(path + fileName + ".tres", tileSet);
	
func addToTileSet(tileset : TileSet, sprite : Sprite):
	var id := tileset.get_last_unused_tile_id();
	var rect := Rect2(Vector2.ZERO, sprite.texture.get_size());
	tileset.create_tile(id);
	tileset.tile_set_name(id, sprite.name);
	tileset.tile_set_texture(id, sprite.texture);
	tileset.tile_set_region(id, rect);
	
