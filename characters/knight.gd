extends CharacterBody2D

@export var move_speed: float = 100
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	# Set input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	# Update velocity
	velocity = input_direction * move_speed
	
	# Move and slide function uses velocity of character body to move character on map
	move_and_slide()
	

func _process(_delta):
	
	# play the animation when the movement keys are pressed
	if Input.is_action_pressed("down") or Input.is_action_pressed("up"):
		_animated_sprite.play("run")
	elif Input.is_action_pressed("right"):
		_animated_sprite.flip_h = false
		_animated_sprite.play("run")
	elif Input.is_action_pressed("left"):
		_animated_sprite.flip_h = true
		_animated_sprite.play("run_left")
	else:
		_animated_sprite.play("stand")
