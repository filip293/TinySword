extends RayCast2D

var InteractObject := ""
var pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Initialization code can go here

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pressed = false
	if is_colliding():
		var detected = get_collider()
		if detected and detected.has_method("get_prompt"):
			InteractObject = detected.get_prompt()
		else:
			InteractObject = ""

func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("interact") or pressed:
		if "Tree" in InteractObject and Global.chopping == false:
			var detected = get_collider()
			while detected and not detected.has_method("hit_tree") and detected.get_parent() != null:
				detected = detected.get_parent()
			if detected and detected.has_method("hit_tree"):
				detected.hit_tree(10)
	if Input.is_action_just_pressed("interact") or pressed:
		if "Wood" in InteractObject and Global.chopping == false:
			var detected = get_collider()
			while detected and not detected.has_method("pick_up") and detected.get_parent() != null:
				detected = detected.get_parent()
			if detected and detected.has_method("pick_up"):
				detected.pick_up()
				
