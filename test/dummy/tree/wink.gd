extends ActionLeaf


var _is_connected: bool = false
var _is_waiting: bool = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not _is_connected:
		_connect_animation_signal(actor as Dummy)
		_is_waiting = true
		(actor as Dummy).wink()
		return RUNNING
	else:
		if _is_waiting:
			return RUNNING
		else:
			_disconnect_animation_signal(actor as Dummy)
			return SUCCESS


func _connect_animation_signal(actor: Dummy) -> void:
	actor.anim.animation_finished.connect(_on_animation_finished)
	_is_connected = true


func _disconnect_animation_signal(actor: Dummy) -> void:
	actor.anim.animation_finished.disconnect(_on_animation_finished)
	_is_connected = false


func _on_animation_finished(animation: String) -> void:
	if animation == "wink":
		_is_waiting = false
