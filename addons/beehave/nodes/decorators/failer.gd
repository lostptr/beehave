class_name AlwaysFailDecorator
extends Decorator
## A Failer node will always return a `FAILURE` status code.

@icon("../../icons/fail.svg")


func tick(actor: Node, blackboard: Blackboard) -> Status:
	for c in get_children():
		var response = c.tick(actor, blackboard)
		if response == Status.RUNNING:
			return Status.RUNNING
	return Status.FAILURE
