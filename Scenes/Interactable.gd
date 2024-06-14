class_name Interactable
extends StaticBody2D

@export var prompt_message = ""

var in_range: bool = false

func get_prompt() -> String:
	return prompt_message
