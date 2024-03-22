extends Area2D

var travelled_distance = 0
var max_distance = 1200
var speed = 300  # Adjust this value to control the initial speed
var deceleration_factor = 0.95  # Adjust this value to control the deceleration rate
var already_hit = false

@onready var hit_sound = preload("res://death.mp3")
var hit_sound_player := AudioStreamPlayer.new()

var timer_elapsed = 0
var max_timer_duration = 2  # Adjust this value to control the duration in seconds

func _ready():
	add_child(hit_sound_player)

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	travelled_distance += speed * delta

	timer_elapsed += delta

	if travelled_distance > max_distance or timer_elapsed > max_timer_duration:
		queue_free()
	else:
		speed *= deceleration_factor

func _on_body_entered(body):
	if not already_hit:
		already_hit = true

		if body.has_method("take_damage"):
			body.take_damage()
			
			# Play the sound when the bullet hits the skull
			hit_sound_player.stream = hit_sound
			hit_sound_player.play()
