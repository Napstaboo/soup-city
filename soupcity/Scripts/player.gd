extends CharacterBody2D

var speed = 80
var health = 2
@onready var pl_animator = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Player") # Replace with function body.

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * speed
	if velocity.length_squared() > 0.2:
		pl_animator.play("run")
	else: pl_animator.play("idle")
		
	if velocity.x < 0:
		pl_animator.flip_h = true
	elif velocity.x > 0:
		pl_animator.flip_h = false
		
	move_and_slide()
	
	
func damage(damage):
	health -= damage
	if health <= 0:
		die()


func die():
	print("you died")
	queue_free()
