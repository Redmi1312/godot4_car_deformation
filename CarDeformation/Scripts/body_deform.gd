extends MeshInstance3D

var mesh_data_tool = MeshDataTool.new()
var deform_timer = 0.0

func _ready():
	if mesh and mesh.get_surface_count() > 0:  # Проверяем, есть ли поверхности
		mesh_data_tool.create_from_surface(mesh, 0)

func apply_deformation(position: Vector3, force: float, radius: float, impact_dir: Vector3):
	if mesh_data_tool.get_vertex_count() == 0:
		return
	
	for i in range(mesh_data_tool.get_vertex_count()):
		var vertex_pos = mesh_data_tool.get_vertex(i)
		var distance = vertex_pos.distance_to(position)
		
		if distance < radius:
			var deformation = (1.0 - (distance / radius)) * force * 10
			vertex_pos += impact_dir.normalized() * deformation  # <- деформируем вдоль направления удара #vertex_pos += Vector3(0, -deformation, 0)  # Деформация вниз
			mesh_data_tool.set_vertex(i, vertex_pos)
	
	deform_timer = 0.1  # Обновлять меш раз в 0.1 сек

func _process(delta):
	if deform_timer > 0:
		deform_timer -= delta
		if deform_timer <= 0:
			update_mesh()

func update_mesh():
	var new_mesh = ArrayMesh.new()
	mesh_data_tool.commit_to_surface(new_mesh)
	mesh = new_mesh
