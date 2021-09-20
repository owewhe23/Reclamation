extends Spatial
enum{
	IDLE,
	ATTACK,
	DEAD
}

var health = 1
var state = IDLE
var target
var minLookAngle : float = -60
var maxLookAngle : float = 60
const TURN_SPEED = 2



signal attack()

onready var raycast = $Armature/Skeleton/Barrel/RayCast
onready var attacktimer = $Timer
onready var barrel = $Armature/Skeleton/Barrel
onready var turret = $Turret

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if health <= 0:
		state = DEAD
	match state:
		DEAD:
			queue_free()
		IDLE:
			rotation_degrees.z = 0
			
		ATTACK:
			turret.rotation_degrees.z = clamp(turret.rotation_degrees.z, minLookAngle+60, maxLookAngle-60)
			barrel.rotation_degrees.z = clamp(barrel.rotation_degrees.z, minLookAngle, maxLookAngle)
			barrel.look_at(target.global_transform.origin + Vector3(0,3,0), Vector3.UP)
			barrel.rotation_degrees.x-=90
			rotate_z(deg2rad(-barrel.rotation.z * TURN_SPEED))
			


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		state = ATTACK
		target = body
		attacktimer.start()
		
		


func _on_Area_body_exited(body):
	state = IDLE
	attacktimer.stop()
	print("stop")


func _on_Timer_timeout():
	emit_signal("attack")

