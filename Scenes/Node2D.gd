extends Node2D

# Reference to the player and the TileMap
@onready var player = $"../Player"
@onready var tilemap = $"../Map"

var previous_layer = -1

func _process(delta):
	var player_position = player.global_position
	var layer = get_player_layer(tilemap, player_position)
	if layer != -1:
		print("Player is on layer ", layer)
	else:
		print("Player is not on any layer")
		
	# Check conditions for changing collision mask
	if layer == 6:
		if previous_layer == 3:
			player.collision_mask = 2
		else:
			player.collision_mask = 1
	else:
		player.collision_mask = 1

	# Update previous layer
	previous_layer = layer
	
	if layer == 1:
		Global.onsand = true
	else:
		Global.onsand = false
	

func get_player_layer(tilemap: TileMap, player_position: Vector2) -> int:
	# Convert global position to local tilemap position
	var local_position = tilemap.to_local(player_position)
	# Convert local position to tilemap coordinates
	var tilemap_position = tilemap.local_to_map(local_position)
	
	var layers_count = tilemap.get_layers_count()

	# Iterate layers from the top to bottom (0 to layers_count - 1)
	for layer in range(layers_count - 1, -1, -1):
		var source_id = tilemap.get_cell_source_id(layer, tilemap_position)
		if source_id != -1:
			return layer
	
	return -1  # Return -1 if the player is not on any layer
