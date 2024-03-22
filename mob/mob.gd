extends CharacterBody2D

var speed = 75.0
var player : Node2D

var health = 1
	
func _ready():
	# Assume the player is a direct child of the scene
	player = get_node("/root/Game/TileMap/player")
	var anim = get_node("CollisionShape2D/AnimatedSprite2D")
	anim.play("skull")


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 45
	move_and_slide()

func take_damage():
	health -= 1
	
	if health == 0:
		queue_free()
