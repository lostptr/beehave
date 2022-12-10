## Selector nodes will attempt to execute each of its children until one of
## them return `SUCCESS`. If all children return `FAILURE`, this node will also
## return `FAILURE`. This node will attempt to process all its children every
## single tick, even if one of them is currently `RUNNING` already.
extends Composite

class_name SelectorComposite
@icon("../../icons/selector.svg")

func tick(actor: Node, blackboard: Blackboard) -> int:
	for c in get_children():
		var response = c.tick(actor, blackboard)
		
		if c is ConditionLeaf:
			blackboard.set_value("last_condition", c)
			blackboard.set_value("last_condition_status", response)

		if response != FAILURE:
			if c is ActionLeaf and response == RUNNING:
				blackboard.set_value("running_action", c)
			
			if response == SUCCESS:
				# A node that was previously running should be halted.
				var running_action: Node = blackboard.get_value("running_action")
				if running_action != null and running_action.has_method("halt"):
					running_action.halt(actor, blackboard)
					blackboard.set_value("running_action", null)
			
			return response

	return FAILURE
