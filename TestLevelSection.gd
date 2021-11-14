extends Spatial

const Section1 = preload("res://Section1.tscn")

func _ready():
	$AudioStreamPlayer.play()
	var s1 = Section1.instance
	get_parent().add_child(s1)
	s1.position = $Spatial3/Position3D.global_position
	
