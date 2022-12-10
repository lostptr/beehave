extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	var has_reached_point: bool = (actor as Dummy).walk(blackboard.get_value("delta"))
	return SUCCESS if has_reached_point else RUNNING
