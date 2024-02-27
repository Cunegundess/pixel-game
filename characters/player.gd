extends CharacterBody2D

@export var move_speed: float = 100
@onready var _animated_sprite = $AnimatedSprite2D

@export var inv = Inv.new()

var bow_equiped = false
var bow_cooldown = true
var arrow = preload("res://weapons/arrow.tscn")
var bow = preload("res://weapons/bow.tscn")
var mouse_loc_from_player = null

func _physics_process(_delta):
	# Set input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	mouse_loc_from_player = get_global_mouse_position() - self.position
	
	# Update velocity
	velocity = input_direction * move_speed
	
	# Move and slide function uses velocity of character body to move character on map
	move_and_slide()
	
	if Input.is_action_just_pressed("weapon_2"):
		
		if !bow_equiped:
			bow_equiped = true
			$Marker2D/bow.visible = true
		else:
			bow_equiped = false
			$Marker2D/bow.visible = false
	
	var mouse_position = get_global_mouse_position()
	$Marker2D.look_at(mouse_position)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.4).timeout
		bow_cooldown = true
	

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
		_animated_sprite.play("idle")
		
func player():
	pass
	
func collect(item):
	inv.insert(item)
