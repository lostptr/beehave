class_name Dummy
extends Node2D


@export var speed: float = 0.2
@export var path_follow: PathFollow2D

@onready var anim: AnimationPlayer = $Animation
@onready var debug: RichTextLabel = $UI/Margin/DebugLabel

var is_captured: bool = false
var _path_parts: int = 3
var _path_part_len: float = 0.0
var _path_index: int = 0

func _ready() -> void:
	_path_part_len = 1.0 / _path_parts


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		print("got captured!")
		is_captured = true


func _physics_process(delta):
	var board = $DummyTree.blackboard.blackboard
	debug.text = "[code]" + _debug_print_blackboard(board) + "[/code]"

func _debug_print_blackboard(blackboard, indent_level: int = 0) -> String:
	var indentation = " ".repeat(indent_level)
	var result = ""
	
	if blackboard is Node:
		return blackboard.name
	elif blackboard is Dictionary:
		for k in blackboard.keys():
			result += "\n%s%s: %s" % [indentation, k, _debug_print_blackboard(blackboard[k], indent_level + 1)]
		return result
	else:
		return "%s" % blackboard


## Returns whether it has passed a point in the path or not. 
func walk(delta: float) -> bool:
	anim.play("walk")
	var progress = path_follow.progress_ratio
	progress = fmod(progress + speed * delta, 1.0)
	path_follow.progress_ratio = progress
	
	var result = false
	var new_path_index := floori(progress / _path_part_len)
	if new_path_index != _path_index:
		result = true
		_path_index = new_path_index
	
	position = path_follow.position
	
	return result


func wink() -> void:
	anim.play("wink")


func die() -> void:
	anim.play("die")


func wait() -> void:
	anim.play("RESET")
