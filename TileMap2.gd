extends TileMap

var player : Node2D  # Reference to your player node

func _process(delta):
	# Assuming you have a player node with a position property
	if player:
		# Adjust the TileMap position based on the player's movement
		position = -player.position
