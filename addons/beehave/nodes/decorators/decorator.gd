## Decorator nodes are used to transform the result received by its child.
## Must only have one child.
@tool
@icon("../../icons/category_decorator.svg")
class_name Decorator extends BeehaveNode


var running_child: BeehaveNode = null


func _ready():
	if Engine.is_editor_hint():
		return
	
	if self.get_child_count() != 1:
		push_warning("Beehave Error: Decorator %s should have only one child (NodePath: %s)" % [self.name, self.get_path()])


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = super._get_configuration_warnings()
	
	if get_child_count() != 1:
		warnings.append("Decorator should have exactly one child node.")
	
	return warnings


func interrupt(actor: Node, blackboard: Blackboard) -> void:
	if running_child != null:
		running_child.interrupt(actor, blackboard)
		running_child = null
