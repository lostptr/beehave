extends ActionLeaf

@export var wait_time: float = 1.0 

@onready var timer: Timer = $Timer

var _is_waiting: bool = false
var _has_started: bool = false


func _ready():
	timer.wait_time = wait_time


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not _has_started:
		_has_started = true
		_is_waiting = true
		actor.wait()
		timer.start()
		return RUNNING
	else:
		if _is_waiting:
			return RUNNING
		else:
			_has_started = false
			return SUCCESS


func halt(actor: Node, balckboard: Blackboard) -> void:
	timer.stop()
	print("halting %s..." % name)


func _on_timer_timeout():
	print("timer timeout")
	_is_waiting = false
