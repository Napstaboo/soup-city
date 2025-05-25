extends Node2D
@export var stats: EnemyStats

func _ready() -> void:
	get_node("skel/Body/Sprite2D").texture = stats.body
	get_node("skel/Head/Sprite2D").texture = stats.head
	get_node("skel/Arm_L/Sprite2D").texture = stats.arm_l
	get_node("skel/Arm_R/Sprite2D").texture = stats.arm_r
	get_node("skel/Leg_L/Sprite2D").texture = stats.leg_l
	get_node("skel/Leg_R/Sprite2D").texture = stats.leg_r
