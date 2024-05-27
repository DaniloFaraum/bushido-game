extends Control

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_texture_button_2_pressed():
	get_tree().quit()
