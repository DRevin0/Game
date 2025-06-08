extends CharacterBody2D
const SPEED = 50.0
@onready var anim = $AnimatedSprite2D
@onready var direction = 1 
@onready var distance = 0
@onready var maxdistance = 200
var chase = false
var hh = 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not anim.is_playing() or anim.animation != "hit":
		var player = $"../../Charaters/Hero"
		if chase == false:
			if direction == 1 and distance >= maxdistance:
				direction = -1
				distance = 0
				$AnimatedSprite2D.flip_h = true
			elif direction == -1 and distance >= maxdistance:
				direction = 1
				distance = 0
				$AnimatedSprite2D.flip_h = false
			velocity.x = direction * SPEED 
			distance += abs(velocity.x) * delta
			anim.play("run")
		else:
			var direct = (player.position - self.position).normalized()
			velocity.x = direct.x * SPEED 
			anim.play("run")
			$AnimatedSprite2D.flip_h = direct.x < 0
			if direct.x < 0:
				direction = -1
			else:
				direction = 1
		move_and_slide()
	
	
func _on_death_2_body_entered(body: Node2D) -> void:
	if body.name == "Hero":
		body.health -= 30
		anim.play("hit")
		
		

func die():
	var death_char = load("res://scenes/skeletondead.tscn").instantiate()
	death_char.global_position = global_position
	get_parent().call_deferred("add_child", death_char)
	call_deferred("queue_free")
	
func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Hero":
		chase = true
func _on_detector_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.name == "Hero":
		chase = false
		distance = 0

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Hero":
		body.velocity.y -= 200
		hh += 1
		print("+1")
	if hh == 3:
		die()

	
