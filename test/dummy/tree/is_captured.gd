extends ConditionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	if (actor as Dummy).is_captured:
		return SUCCESS
	else:
		return FAILURE
