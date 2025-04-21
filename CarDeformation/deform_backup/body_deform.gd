extends MeshInstance3D

var mesh_data_tool: MeshDataTool

func _ready():
	if mesh is ArrayMesh:
		mesh_data_tool = MeshDataTool.new()
		mesh_data_tool.create_from_surface(mesh, 0)

# Функция для деформации в точке удара
func deform(hit_position: Vector3, force: float = 0.2):
	if mesh_data_tool == null:
		return
	
	var modified = false  # Флаг для проверки, менялись ли вершины
	
	for i in range(mesh_data_tool.get_vertex_count()):
		var vertex_position = mesh_data_tool.get_vertex(i)
		# Проверяем, близка ли вершина к месту удара
		var distance = hit_position.distance_to(vertex_position)
		
		print("Hit Position (local):", hit_position)
		print("Vertex Position:", vertex_position)
		print("Distance:", distance)
		if distance < 40.0:  # Радиус деформации
			var direction = (hit_position - vertex_position).normalized()  # Двигаем вершины ВНИЗ, а не вверх
			var new_position = vertex_position + direction * force * (1.0 - (distance / 100.0))
			mesh_data_tool.set_vertex(i, new_position)
			modified = true
	
	if modified:
		print("Vertices modified, applying changes")
		apply_mesh_changes()
	else:
		print("No vertices modified, skipping update")

func apply_mesh_changes():
	var new_mesh = ArrayMesh.new()
	
	# Создаём новый меш из MeshDataTool
	mesh_data_tool.commit_to_surface(new_mesh)
	
	# Сохраняем материал, чтобы машина не становилась белой
	new_mesh.surface_set_material(0, mesh.surface_get_material(0))
	
	# Применяем новый меш
	mesh = new_mesh
