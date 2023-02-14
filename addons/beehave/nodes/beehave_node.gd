## A node in the behaviour tree. Every node must return `SUCCESS`, `FAILURE` or
## `RUNNING` when ticked.
@tool
class_name BeehaveNode extends Node


enum {
	SUCCESS,
	FAILURE,
	RUNNING
}

var _is_running: bool = false


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	
	if get_children().any(func(x): return not (x is BeehaveNode)):
		warnings.append("All children of this node should inherit from BeehaveNode class.")
	
	return warnings


## Executes this node and returns a status code.
## This method must be overwritten.
func tick(actor: Node, blackboard: Blackboard) -> int:
	return SUCCESS


## Called when this node needs to be interrupted before it can return FAILURE or SUCCESS.
func interrupt(actor: Node, blackboard: Blackboard) -> void:
	pass


## Called before the first time it ticks by the parent.
func before_run(actor: Node, blackboard: Blackboard) -> void:
	pass


## Called after the last time it ticks and returns
## [code]SUCCESS[/code] or [code]FAILURE[/code].
func after_run(actor: Node, blackboard: Blackboard) -> void:
	pass


func _execute(actor: Node, blackboard: Blackboard) -> int:
	if not _is_running:
		_is_running = true
		before_run(actor, blackboard)
	
	var status = tick(actor, blackboard)

	if status != RUNNING:
		_is_running = false
		after_run(actor, blackboard)
