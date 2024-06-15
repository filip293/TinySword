extends CharacterBody2D

const SPEED = 300
var footstep_timer = 0
var footstep_interval = 0.3
var is_right_foot = true

@onready var raycast = $RayCast2D


func _ready():
	pass

func _physics_process(delta):
	velocity = Vector2()


	if $Theme.is_playing() == false:
		$Theme.play()
	
	
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

	if velocity.length() > 0 and Global.chopping == false:
		velocity = velocity.normalized() * SPEED

		footstep_timer += delta
		if footstep_timer >= footstep_interval:
			footstep_timer = 0.0
			is_right_foot = !is_right_foot
			if Global.onsand == false:
				if is_right_foot:
					$RightFoot.play()
				else:
					$LeftFoot.play()
			elif Global.onsand == true:
				if is_right_foot:
					$Sand1.play()
				else:
					$Sand2.play()
		
		$Animations.play("Walk")
		$Animations.flip_h = (velocity.x < 0)
	else:
		if Global.chopping == false:
			$Animations.play("Idle")
		
	if velocity.x < 0:
		raycast.target_position = Vector2(-80, 0)
	elif velocity.x > 0:
		raycast.target_position = Vector2(80, 0)
		
	if velocity.y < 0:
		raycast.target_position = Vector2(0, -80)
	elif velocity.y > 0:
		raycast.target_position = Vector2(0, 80)

	move_and_slide()
