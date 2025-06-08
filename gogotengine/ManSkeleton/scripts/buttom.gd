extends CanvasLayer

@export var hero_node_path : NodePath = "../Charaters/Hero"

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/legend_dificulty.tscn")
	


func _on_right_button_down() -> void:
	get_node(hero_node_path).buttom_right = true
func _on_right_button_up() -> void:
	get_node(hero_node_path).buttom_right = false

func _on_left_button_up() -> void:
	get_node(hero_node_path).buttom_left = false
func _on_left_button_down() -> void:
	get_node(hero_node_path).buttom_left = true

func _on_up_2_button_down() -> void:
	get_node(hero_node_path).buttom_up = true
func _on_up_2_button_up() -> void:
	get_node(hero_node_path).buttom_up = false
