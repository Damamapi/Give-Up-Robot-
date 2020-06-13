tool
extends Button

export(String, FILE) var nextScene: = ""

func _on_button_up() -> void:
	get_tree().change_scene(nextScene)

func _get_configuration_warning() -> String:
	return "nextScene must be set for the button to work" if nextScene == "" else ""
