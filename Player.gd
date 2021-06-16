extends KinematicBody

const MOVE_SPEED = 10
const JUMP_FORCE = 15
const GRAVITY = 15
const MAX_FALL_SPEED = 50
var y_velo = 0
var facing_right = false
var attacking = false

signal attack_over

onready var anim_player = $Graphics/AnimationPlayer

func _physics_process(delta):
	self.transform.origin.z = 1
	var move_dir = 0
	
	if attacking == false:
		if Input.is_action_pressed("move_right"):
			move_dir += 1
		if Input.is_action_pressed("move_left"):
			move_dir -= 1
	elif attacking == true:
		pass
	
	if Input.is_action_pressed("attack"):
		attacking = true
	
	move_and_slide(Vector3(move_dir * MOVE_SPEED, y_velo, 0), Vector3(0,1,0))
	
	var just_jumped = false
	var grounded = is_on_floor()
	y_velo -= GRAVITY * delta
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
	
	if grounded and attacking == false:
		y_velo = -0.1
		if Input.is_action_pressed("jump"):
			y_velo = JUMP_FORCE
			just_jumped = true
	
	if move_dir < 0 and facing_right:
		flip()
	if move_dir > 0 and !facing_right:
		flip()
	
	if attacking == false:
		if just_jumped:
			$Graphics/AnimationPlayer.play("Jump_Player")
		elif grounded:
			if move_dir == 0:
				$Graphics/AnimationPlayer.play("Idle - Player")
			else:
				$Graphics/AnimationPlayer.play("Run - Player")
	elif attacking == true and grounded:
		$Graphics/AnimationPlayer.play("Attack_Player")
		


func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play()

func flip():
	$Graphics.rotation_degrees.y *=-1
	facing_right = !facing_right


func _on_AnimationPlayer_animation_finished(Attack_Player):
	attacking = false
