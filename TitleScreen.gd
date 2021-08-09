extends Control

var fade_options = false
var fade_game = false
var fade_quit = false
onready var anim = $MarginContainer/FadeIn/AnimationPlayer

func _ready():
	anim.play("fade_in")


func _on_Quit_pressed():
	anim.play("fade_out")
	fade_quit = true


func _on_Start_pressed():
	anim.play("fade_out")
	fade_game = true


func _on_Options_pressed():
	anim.play("fade_options")
	fade_options = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if fade_quit == true:
		get_tree().quit()
	elif fade_game == true:
		get_tree().change_scene("res://TestLevelSection.tscn")
	elif fade_options == true:
		get_tree().change_scene("res://Options.tscn")
