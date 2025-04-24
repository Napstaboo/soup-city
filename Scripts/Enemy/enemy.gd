extends CharacterBody2D

@export var stats: EnemyStats
var player: Node2D
var bullet: PackedScene

#movement
var attraction
var repulsion
var separation
var acceleration
var move_jitter

#health and damage
var health

var is_stunned = false
var can_shoot = true


func _ready() -> void:
	attraction = stats.attraction
	repulsion = stats.repulsion
	separation = stats.separation
	acceleration = stats.acceleration
	move_jitter = stats.move_jitter

	#health and damage
	health = stats.health
	
	add_to_group("Enemies")
	player = get_node("../Player")
	bullet = stats.bullet
	

		
func _physics_process(_delta: float) -> void:
	#movement
	#Springs between player and enemy
	var pl_distance = global_position.distance_to(player.global_position)
	var pl_direction = global_position.direction_to(player.global_position)
	
	var player_spring = (
		(pl_direction * pl_distance * attraction) +
		(- pl_direction * (1/(pl_distance + 0.2)) * repulsion))
		
	#Springs between enemy and other enemies
		#get other enemies (OPTIMIZE by only looking for enemies in a radius?)

	var enemy_array = get_tree().get_nodes_in_group("Enemies")
	var enemy_springs = Vector2.ZERO
	for enemy in enemy_array:
		if enemy != self:
			var en_distance = global_position.distance_to(enemy.global_position)
			var en_direction = global_position.direction_to(enemy.global_position)
			enemy_springs += + en_direction * (1/(en_distance + 0.2)) * separation
			#print(player_spring.length())
	
	#Random sideway movement
	var t = Transform2D() #90 degree rotation
	t.x.x = 0
	t.y.y = 0
	t.x.y = 1
	t.y.x = -1
	var side_vec = t * pl_direction #perpendicular to direction of player
	
	var random_push =  side_vec * move_jitter
	
	var target_velocity = (player_spring + enemy_springs)
	
	if !is_stunned:
		velocity = (target_velocity * _delta * acceleration + random_push)
	else	: velocity = Vector2.ZERO
	
	move_and_slide()
	
	#shooting
	#if shoot_timer < 0.1:
	if can_shoot:
		var chance = randf_range(0, 1)
		if chance > 0.25 && !is_stunned:
			#shoot(pl_direction)
			pass
		#shoot_timer = shoot_duration
		can_shoot = false
		#print("stun is " + str(is_stunned))
		%ShootTimer.start()
	#else: shoot_timer -= _delta
	
	
func shoot(direction):
	#print("shoot!")
	var b = bullet.instantiate()
	add_child(b)
	b.rotation = direction.angle()
	b.direction = direction
	b.global_position = global_position
	
	
func damage(damage_amount):
	health -= damage_amount
	print("damage taken!")
	stun()
	if(health == 0):
		die()


func stun():
	is_stunned = true
	%StunTimer.start()
	print("stunned")
	self.position -= 10 * global_position.direction_to(player.global_position)
	pass
		
		
func die():
	#print("i am dead")
	queue_free()


func _on_stun_timer_timeout() -> void:
	is_stunned = false
	velocity = Vector2.ZERO
	%StunTimer.stop()


func _on_shoot_timer_timeout() -> void:
	can_shoot = true
	%ShootTimer.stop()
