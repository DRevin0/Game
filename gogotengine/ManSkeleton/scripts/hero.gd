extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var anim = $AnimatedSprite2D

var health = 100
var is_alive = true
var buttom_left = false
var buttom_right = false
var buttom_up = false

func _ready() -> void:
	anim.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not anim.is_playing() or (anim.animation not in ["death", "sleep"]):
		if (Input.is_action_just_pressed("ui_accept") or buttom_up == true) and is_on_floor():
			anim.play("jump")
			velocity.y = JUMP_VELOCITY

		#С клавиатуры
		var direction := Input.get_axis("ui_left", "ui_right")
		#С кнопок
		if buttom_left:
			direction = -1
		elif buttom_right:
			direction = 1
			
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				anim.play("idle")
		if direction == -1:
			$AnimatedSprite2D.flip_h = true;
		elif direction == 1:
			$AnimatedSprite2D.flip_h = false;
			
		if velocity.y > 0:
			anim.play("fall")
		heal()
			
		move_and_slide()
	
func heal():
	if health < 0:
		health = 0
		die()
func die():
	anim.play("death")
	await anim.animation_finished
	anim.play("sleep")

	
