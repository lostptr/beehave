class_name AlwaysSucceedDecorator
extends Decorator

## A succeeder node will always return a `SUCCESS` status code.

@icon("../../icons/succeed.svg")


func tick(actor: Node, blackboard: Blackboard) -> Status:
	for c in get_children():
		var response = c.tick(actor, blackboard)
		if response == Status.RUNNING:
			return Status.RUNNING
		return Status.SUCCESS
