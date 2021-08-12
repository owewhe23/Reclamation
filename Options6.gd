extends Control

var fade_out = false
onready var anim = $MarginContainer/Fade/AnimationPlayer

func _ready():
	anim.play("fade_in")



func _on_Menu_pressed():
	anim.play("fade_out")
	fade_out = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if fade_out == true:
		get_tree().change_scene("res://TitleScreen.tscn")
