extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Grab the atlas and create a texture for it
	var atlas_source: TileSetAtlasSource = (load("res://tilesets/cursors.tres") as TileSet).get_source(0)
	var tex: Texture2D = atlas_source.texture
	var atex: AtlasTexture = AtlasTexture.new()
	atex.atlas = tex
	
	var pointer_rect: Rect2i = atlas_source.get_tile_texture_region(Vector2i(8, 1))
	atex.region = pointer_rect
	Input.set_custom_mouse_cursor(atex, Input.CURSOR_ARROW)

	var wrench_rect: Rect2i = atlas_source.get_tile_texture_region(Vector2i(12, 6))
	atex.region = wrench_rect
	Input.set_custom_mouse_cursor(atex, Input.CURSOR_CROSS)
