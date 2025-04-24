extends Area2D

var target_pos = Vector2.ZERO
var in_range = []
var damage = 1

var can_shoot = true

func _input(event: InputEvent) -> void:
		
	if event is InputEventJoypadMotion:
		target_pos = Input.get_vector("point_left","point_right","point_down","point_up")
		print("joystick look not setup in weapon.gd")
			
		
func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if can_shoot:
		shoot()

	
func shoot():
	if Input.is_action_just_pressed("shoot"):
		can_shoot = false
		%Reload.start()
		for enemy in in_range:
			if enemy.has_method("damage"):
				#print("slash!")
				enemy.damage(damage)
			if enemy.has_method("destroy"):
				enemy.destroy()
		
	
	
func _on_body_entered(body: Node2D) -> void:
	in_range.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body in in_range:
		in_range.erase(body)
		#print("enemy exited")


func _on_area_entered(area: Area2D) -> void:
	in_range.append(area)
	print(area.name)
	

func _on_area_exited(area: Area2D) -> void:
	if area in in_range:
		in_range.erase(area)


func _on_reload_timeout() -> void:
	can_shoot = true
	%Reload.stop()
