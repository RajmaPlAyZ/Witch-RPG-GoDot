extends CharacterBody2D
signal health_depleted

const SPEED = 100.0
var health = 100.0 

@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var gunshot_sound = preload("res://Player/mob_sound.mp3")
var gunshot_player = AudioStreamPlayer.new()

func _ready():
	anim.play("idle")
	add_child(gunshot_player)

	
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	if direction.x < 0:
		# Face left when moving left
		anim.scale.x = -1.0
	elif direction.x > 0:
		# Face right when moving right
		anim.scale.x = 1.0

	if direction == Vector2(0, 0):
		anim.play("idle")
	else:
		anim.play("run")

	move_and_slide()
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		gunshot_player.stream = gunshot_sound
		gunshot_player.play()
		%ProgressBar.value = health
		%ProgressBar.max_value = 100.0
		if health <= 0.0:
			get_tree().change_scene_to_file("res://menu.tscn")
