class_name BeehaveNode 
extends BeehaveTree

## A node in the behaviour tree. Every node must return `SUCCESS`, `FAILURE` or
## `RUNNING` when ticked.

@icon("../icons/action.svg")


func tick(actor: Node, blackboard: Blackboard) -> Status:
	pass
