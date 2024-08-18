extends Node

var atlas_source: TileSetAtlasSource
var tex: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Grab the atlas and create a texture for it
	atlas_source = (load("res://tilesets/cursors.tres") as TileSet).get_source(0)
	tex = atlas_source.texture
	
	set_cursor_to_arrow()

func set_cursor_to_arrow() -> void:
	var pointer_rect: Rect2i = atlas_source.get_tile_texture_region(Vector2i(8, 1))
	var atex: AtlasTexture = AtlasTexture.new()
	atex.region = pointer_rect
	atex.atlas = tex
	Input.set_custom_mouse_cursor(atex)

func set_cursor_to_wrench() -> void:
	var wrench_rect: Rect2i = atlas_source.get_tile_texture_region(Vector2i(12, 6))
	var atex: AtlasTexture = AtlasTexture.new()
	atex.region = wrench_rect
	atex.atlas = tex
	Input.set_custom_mouse_cursor(atex)
