extends Node2D
@export var stats: EnemyStats

func _ready() -> void:
	get_node("Skel/Body/Sprite2D").texture = stats.body
	get_node("Skel/Head/Sprite2D").texture = stats.head
	get_node("Skel/Arm_L/Sprite2D").texture = stats.arm_l
	get_node("Skel/Arm_R/Sprite2D").texture = stats.arm_r
	get_node("Skel/Leg_L/Sprite2D").texture = stats.leg_l
	get_node("Skel/Leg_R/Sprite2D").texture = stats.leg_r
