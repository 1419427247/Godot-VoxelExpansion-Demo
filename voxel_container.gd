extends VBoxContainer

const GDChunk = preload("res://packed_scene/gd_chunk.tscn")

@onready
var voxel_room : VoxelRoom = $"../../VoxelRoom"

@onready
var message = $"../Message"

var chunks : Array[GDChunk]
func _ready():
	var world_size : Vector3i = voxel_room.voxel_container_data.container_size
	for x in range(0,world_size.x / voxel_room.chunk_size.x):
		for y in range(0,world_size.y / voxel_room.chunk_size.y):
			for z in range(0,world_size.z / voxel_room.chunk_size.z):
				var chunk : GDChunk = GDChunk.instantiate()
				chunk.chunk_position = Vector3i(x,y,z)
				chunk.position = Vector3i(
					x * voxel_room.chunk_size.x,
					y * voxel_room.chunk_size.y,
					z * voxel_room.chunk_size.z,
				)
				voxel_room.add_child(chunk)
				chunks.append(chunk)

func _process(delta):
	pass

func _on_random_place_voxels_button_pressed():
	var world_size : Vector3i = voxel_room.voxel_container_data.container_size
	for x in range(world_size.x):
		for y in range(world_size.y):
			for z in range(world_size.z):
				var rotation : Vector3i
				if($RandomRotationCheckBox.button_pressed):
					rotation = Vector3i(randi() % 360,randi() % 360,randi() % 360)
				if(randi() % 100 <= $Opportunity.value):
					var id = randi() % 3 + 1
					match id:
						1:
							if($BasicsVoxelCheckBox.button_pressed):
								voxel_room.set_voxel(Vector3i(x,y,z),voxel_room.basics_voxel(0,rotation))
						2: 
							if($MeshVoxelCheckBox.button_pressed):
								voxel_room.set_voxel(Vector3i(x,y,z),voxel_room.mesh_voxel(0,rotation))
	message.print("place voxels")

func _on_clear_all_voxels_button_pressed():
	var world_size : Vector3i = voxel_room.voxel_container_data.container_size
	for x in range(world_size.x):
		for y in range(world_size.y):
			for z in range(world_size.z):
					voxel_room.set_voxel(Vector3i(x,y,z),voxel_room.empty_voxel())
	message.print("Clear all voxels")
	
func _on_build_mesh_button_pressed():
	var v = Time.get_ticks_msec()
	for chunk in chunks:
		chunk.open_mesh()
	message.print("The build mesh time spent: " + str(Time.get_ticks_msec() - v) + "ms")

func _on_clear_mesh_button_pressed():
	for chunk in chunks:
		chunk.close_mesh()
	message.print("Clear mesh")

func _on_build_collider_button_pressed():
	var v = Time.get_ticks_msec()
	for chunk in chunks:
		chunk.open_collider()
	message.print("The build collider time spent: " + str(Time.get_ticks_msec() - v) + "ms")

func _on_clear_collider_button_pressed():
	for chunk in chunks:
		chunk.close_collider()
	message.print("Clear collider")
