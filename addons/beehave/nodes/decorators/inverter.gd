class_name InverterDecorator
extends Decorator
## An inverter will return `FAILURE` in case it's child returns a `SUCCESS` status
## code or `SUCCESS` in case its child returns a `FAILURE` status code.

@icon("../../icons/inverter.svg")


func tick(actor: Node, blackboard: Blackboard) -> Status:
	for c in get_children():
		var response = c.tick(actor, blackboard)

		if response == Status.SUCCESS:
			return Status.FAILURE
		if response == Status.FAILURE:
			return Status.SUCCESS

		if c is Leaf and response == Status.RUNNING:
			blackboard.set_value("running_action", c)
		return Status.RUNNING
