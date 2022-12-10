## Actions are leaf nodes that define a task to be performed by an actor.
## Their execution can be long running, potentially being called across multiple
## frame executions. In this case, the node should return `RUNNING` until the
## action is completed.
extends Leaf

class_name ActionLeaf
@icon("../../icons/action.svg")


## This method is called whenever a long running action is being prematuraly stopped.
## Useful for when you need to do some clean up before another node in the tree is processed.
func halt(actor: Node, blackboard: Blackboard) -> void:
	pass
