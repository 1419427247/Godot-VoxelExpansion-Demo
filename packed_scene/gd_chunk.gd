@tool
extends Chunk

class_name GDChunk

@onready
var mesh_instance : MeshInstance3D = $MeshInstance

@onready
var collision_shape : CollisionShape3D = $StaticBody/CollisionShape

# Called when the node enters the scene tree for the first time.
func _ready():
	print()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_mesh():
	mesh_instance.mesh = generate_mesh()

func open_collider():
	collision_shape.shape = generate_collider()

func close_mesh():
	mesh_instance.mesh = null
	
func close_collider():
	collision_shape.shape = null
	

