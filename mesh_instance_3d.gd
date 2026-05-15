extends MeshInstance3D
@export var mat: Material
@export var world_size: Vector3 = Vector3(16,16,16)

func _ready() -> void:

	var meshInst = MeshInstance3D.new()
	add_child(meshInst)

	var st = SurfaceTool.new()

	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	for x in range(world_size.x):
		for y in range(world_size.y):
			for z in range(world_size.z):
				add_cube(st, Vector3(x, y, z))

	st.generate_normals()

	meshInst.mesh = st.commit()
	meshInst.create_trimesh_collision()
	meshInst.mesh.surface_set_material(0, mat)

func add_cube(st, pos):

	var p = pos

	# Frente
	add_quad(
		st,
		p + Vector3(0,0,1),
		p + Vector3(1,0,1),
		p + Vector3(1,1,1),
		p + Vector3(0,1,1)
	)

	# Trás
	add_quad(
		st,
		p + Vector3(1,0,0),
		p + Vector3(0,0,0),
		p + Vector3(0,1,0),
		p + Vector3(1,1,0)
	)

	# Esquerda
	add_quad(
		st,
		p + Vector3(0,0,0),
		p + Vector3(0,0,1),
		p + Vector3(0,1,1),
		p + Vector3(0,1,0)
	)

	# Direita
	add_quad(
		st,
		p + Vector3(1,0,1),
		p + Vector3(1,0,0),
		p + Vector3(1,1,0),
		p + Vector3(1,1,1)
	)

	# Topo
	add_quad(
		st,
		p + Vector3(0,1,1),
		p + Vector3(1,1,1),
		p + Vector3(1,1,0),
		p + Vector3(0,1,0)
	)

	# Baixo
	add_quad(
		st,
		p + Vector3(0,0,0),
		p + Vector3(1,0,0),
		p + Vector3(1,0,1),
		p + Vector3(0,0,1)
	)


func add_quad(st, a, b, c, d):

	st.add_vertex(a)
	st.add_vertex(c)
	st.add_vertex(b)

	st.add_vertex(a)
	st.add_vertex(d)
	st.add_vertex(c)	
