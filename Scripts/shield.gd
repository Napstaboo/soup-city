extends Area2D

var max_health = 3
var health = max_health
var can_shield = true

var bullets_in_range = []


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("shield") && can_shield:
		$ShieldCollider.disabled = false
	
	else: 
		$ShieldCollider.disabled = true
			
	if Input.is_action_just_released("shield"):
		print("action released")
		break_shield()
		
	if Input.is_action_just_pressed("shoot"):
		break_shield()

func damage(_damageamount):
	health -= -1
	if health <= 0:
		break_shield()
		explode()
		
		
func break_shield():
	print("shield broke")
	can_shield = false
	health = max_health
	if %ShieldTimer.time_left > 0:
		return
	else: %ShieldTimer.start()


func _on_shield_timer_timeout() -> void:
	can_shield = true
	print("shield back")
	%ShieldTimer.stop()


func explode():
	for bullet in bullets_in_range:
		if bullet.has_method("destroy"):
			bullet.destroy()
	

func _on_explosion_area_entered(bullet: Area2D) -> void:
	bullets_in_range.append(bullet)


func _on_explosion_area_exited(bullet: Area2D) -> void:
	if bullet in bullets_in_range:
		bullets_in_range.erase(bullet)
