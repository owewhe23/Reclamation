extends Spatial
var target

onready var raycast = $RayCast
onready var attacktimer = $Timer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		attacktimer.start()


func _on_Area_body_exited(body):
	attacktimer.stop()


func _on_Timer_timeout():
	if raycast.is_colliding():
		var hit = raycast.get_collider()
		if hit.is_in_group("Player"):
			attacktimer.start()
