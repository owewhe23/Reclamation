extends Spatial

var vel = Vector3()
var movementSpeed : float = 10
var jumpForce : float = 5
var gravity : float = 15
var cur_hp : int = 100
var max_hp : int = 100
var score : int = 0

enum{
	IDLE,
	RUN,
	JUMP,
	ATTACK,
	DEATH
}
var state = IDLE
onready var ap = $AnimationPlayer


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	print(is_on_floor())
	vel.x = 0
	movementSpeed = 5
	
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	input = input.normarlized()
	var right = global_transform.basis.x
	var relativeDirection = (right*input.x)



