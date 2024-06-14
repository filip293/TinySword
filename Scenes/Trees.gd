extends Node2D

@export var health := 100

@onready var TreeHit := $TreeHit
@onready var tree_sprite := $Tree
@onready var wood_node := $Wood
@onready var animationsPlayer = $/root/Node2D/Player/Animations

func _ready():
	wood_node.visible = false
	$Wood/StaticBody2D/CollisionShape2D.disabled = true
		
func hit_tree(damage: int):
	health -= damage
	print(health)
	if health > 0:
		TreeHit.play()
		Global.chopping = true
		animationsPlayer.play("Chop")
		await get_tree().create_timer(0.25).timeout
		tree_sprite.play("TreeCut")
		await get_tree().create_timer(0.20).timeout
		Global.chopping = false
	else:
		$Tree/StaticBody2D/CollisionShape2D.disabled = true
		await get_tree().create_timer(0.1).timeout
		TreeHit.play()
		Global.chopping = true
		animationsPlayer.play("Chop")
		await get_tree().create_timer(0.25).timeout
		tree_sprite.play("TreeCut")
		await get_tree().create_timer(0.20).timeout
		Global.chopping = false
		fall_down()

func _on_TreeCut_finished():
	tree_sprite.play("Tree")

func fall_down():
	tree_sprite.play("TreeStub")
	drop_wood()

func drop_wood():
	wood_node.visible = true
	$Wood/StaticBody2D/CollisionShape2D.disabled = false
	
	var drop_position = global_position + Vector2(randf_range(-20, 20), randf_range(-20, 20))  # Adjusted offset range
	
	wood_node.global_position = drop_position
	wood_node.play("WoodDrop")

func pick_up():
	$Wood.play("Pickup")
	await get_tree().create_timer(0.25).timeout
	wood_node.queue_free()

func _on_WoodDrop_finished(wood):
	wood.play("WoodIdle")

func get_prompt() -> String:
	return "Tree"

