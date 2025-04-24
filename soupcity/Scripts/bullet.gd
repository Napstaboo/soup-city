extends Area2D

var speed = 100
var direction = Vector2.ZERO
var age = 10
var damage_amount = 1

func _ready() -> void:
	#print("bullet spawned")
	pass


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	
func _process(delta: float) -> void:
	age -= delta
	if age < 0.1:
		queue_free()
		
		
func destroy():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.has_method("damage"):
			#print("hit!")
			body.damage(damage_amount)
			queue_free()
	queue_free()
	

func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.has_method("damage"):
			#print("hit!")
			area.damage(damage_amount)
			queue_free()
	queue_free()
