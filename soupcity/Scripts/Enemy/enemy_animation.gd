extends Node2D
@export var stats: EnemyStats

func _ready() -> void:
	var BodyTex = stats.sprite
	get_node("skel/Body/Sprite2D").texture = BodyTex
