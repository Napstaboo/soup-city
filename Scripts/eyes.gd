extends Sprite2D

var look = Vector2.ZERO
var pos = Vector2.ZERO

func _ready() -> void:
	pos = self.position

func _process(_delta: float) -> void:
	self.position=pos
	var vec = get_global_mouse_position()
	look = (vec - self.global_position).normalized()
	
	self.position += look*5
