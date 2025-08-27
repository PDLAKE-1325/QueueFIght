extends Camera3D

@export var shake_size: float = 0.5
@export var shake_decay: float = 3.0 #감쇠
@export var shake_speed: float = 20.0

var _shake_strength: float = 0.0
var _original_transform: Transform3D
var _time_passed: float = 0.0

func _ready():
	_original_transform = global_transform

func start_shake(shake_size_: float = 0.5):
	_shake_strength = shake_size_

func _process(delta: float):
	if _shake_strength > 0.01:
		_time_passed += delta * shake_speed

		var x_offset = (randf() * 2.0 - 1.0) * _shake_strength
		var y_offset = (randf() * 2.0 - 1.0) * _shake_strength
		var z_rot = sin(_time_passed) * _shake_strength * 0.5

		global_transform = _original_transform
		global_translate(Vector3(x_offset, y_offset, 0))
		rotate_object_local(Vector3(0, 0, 1), z_rot)

		_shake_strength = lerp(_shake_strength, 0.0, delta * shake_decay)
	else:
		global_transform = _original_transform

#$Camera3D.start_shake(0.7)
