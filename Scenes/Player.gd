extends CharacterBody2D

const SPEED = 300
var footstep_timer = 0
var footstep_interval = 0.25
var is_right_foot = true

func _ready():
	pass

func _physics_process(delta):
	velocity = Vector2(0, 0)
	#velocity = $/root/Node2D/Level1/UI/Joysrick.get_valo()
	if Input.is_action_pressed("esc"):
		get_tree().quit()

	if Input.is_action_pressed("Left"):
		velocity.x -= SPEED
	elif Input.is_action_pressed("Right"):
		velocity.x += SPEED
	if Input.is_action_pressed("Up"):
		velocity.y -= SPEED
	elif Input.is_action_pressed("Down"):
		velocity.y += SPEED

	#if velocity.length() > 0:
		#velocity = velocity.normalized() * SPEED
		#
		#footstep_timer += delta
		#if footstep_timer >= footstep_interval:
			#footstep_timer = 0.0
			#is_right_foot = !is_right_foot
			#if is_right_foot:
				#$RightFoot.play()
			#else:
				#$LeftFoot.play()
			

	if velocity.length() > 0:
		$Animations.play("Walk")
		$Animations.flip_h = (velocity.x < 0)
		$Animations.flip_h = (velocity.x < 0)
	else:
		$Animations.play("Idle")

	move_and_slide()

