extends KinematicBody

const MOVE_SPEED = 10
const JUMP_FORCE = 23
const GRAVITY = 30
const MAX_FALL_SPEED = 75
var y_velo = 0
var facing_right = false
var attacking = false
var melee_damage = 50

export (float) var max_health = 50

signal health_update(health)

onready var hitbox = $Graphics/Area
onready var health = max_health setget _set_health
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
		melee()
	
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
	elif attacking == true:
		if grounded:
			$Graphics/AnimationPlayer.play("Attack_Player")
		else:
			attacking = false
		
func life():
	pass

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play()

func flip():
	$Graphics.rotation_degrees.y *=-1
	facing_right = !facing_right


func _on_AnimationPlayer_animation_finished(Attack_Player):
	attacking = false


func melee():
	if attacking == true:
		for body in hitbox.get_overlapping_bodies():
			if body.is_in_group("Turret"):
				yield(get_tree().create_timer(0.4), "timeout")
				body.health -= melee_damage
				print("damaged")
	yield(anim_player, "animation_finished")

func kill():
	pass

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_update", health)
		if health == 0:
			kill()

func damage():
	_set_health(health - 1)









