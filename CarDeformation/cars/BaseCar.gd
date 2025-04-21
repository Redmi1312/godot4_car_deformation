# 0.0.2
extends VehicleBody3D
class_name BaseCar

@export var STEER_SPEED = 1.5
@export var STEER_LIMIT = 0.6
var steer_target = 0
@export var engine_force_value = 40

var fwd_mps : float
var speed: float

func _ready():
	%CarResetter.init()
	connect("body_entered", Callable(self, "_on_body_entered"))


func _physics_process(delta):
	speed = linear_velocity.length()*Engine.get_frames_per_second()*delta
	fwd_mps = transform.basis.x.x
	traction(speed)
	process_accel(delta)
	process_steer(delta)
	process_brake(delta)
	%Hud/speed.text=str(round(speed*3.8))+"  KMPH"
	if Input.is_action_just_pressed("V"):
		#$"doge-body/Body".deform(Vector3(5, 1, 15), -1)
		#$"doge-body/Hood".deform(Vector3(5, 1, 15), -1)
		#$"doge-body/Door_FL".deform(Vector3(5, 1, 15), -0.7)
		#$"doge-body/Door_FR".deform(Vector3(5, 1, 15), -0.7)
		#$"doge-body/Doorcard_FR".deform(Vector3(5, 1, 15), -1)
		#$"doge-body/Doorglass_FR".deform(Vector3(5, 1, 15), -1)
		#$"doge-body/Grill".deform(Vector3(5, 1, 15), -1)
		
		#$"doge-body/Body".apply_deformation(Vector3(5, 1, 15), 0.5, 15)
		#$"doge-body/Hood".apply_deformation(Vector3(5, 1, 15), 0.5, 15)
		#$"doge-body/Door_FL".apply_deformation(Vector3(5, 1, 15), 0.2, 15)
		#$"doge-body/Door_FR".apply_deformation(Vector3(5, 1, 15), 0.2, 15)
		#$"doge-body/Doorcard_FR".apply_deformation(Vector3(5, 1, 15), 0.5, 15)
		#$"doge-body/Doorglass_FR".apply_deformation(Vector3(5, 1, 15), 0.5, 15)
		#$"doge-body/Grill".apply_deformation(Vector3(5, 1, 15), 0.5, 15)
		#$"doge-body/Doorcard_FL".apply_deformation(Vector3(5, 1, 15), 0.5, 15)
		#$"doge-body/Door_inner_FL".apply_deformation(Vector3(5, 1, 15), 0.5, 15)
		
		
		$"doge-body/Body".apply_deformation(Vector3(5, 1, 55), 0.7, 25)
		$"doge-body/Grill".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Hood".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Door_FL".apply_deformation(Vector3(5, 1, 55), 0.3, 25)
		$"doge-body/Trunkdoor".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Doorglass_FL".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Windshield".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Hood_inner".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Taillights".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Suspension_front".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Bottom".apply_deformation(Vector3(5, 1, 55), 0.5, 35)
		$"doge-body/Taillights_glass_reverse".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Headlights_glass".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Turnsignals_glass".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Badges_body".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Badges_hood".apply_deformation(Vector3(5, 1,55), 0.5, 25)
		$"doge-body/Exhaust".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Numberplate_rear".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Dashboard".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Seats".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Doorcard_FL".apply_deformation(Vector3(5, 1, 55), 1, 25)
		$"doge-body/Door_inner_FL".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Trunkdoor_inner".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Engine_Plarts_muscle".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Taillights_glass_brakelights".apply_deformation(Vector3(5, 1, 15), 0.5, 25)
		$"doge-body/Glass_rear".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Door_FR".apply_deformation(Vector3(5, 1, 55), 0.3, 25)
		$"doge-body/Door_inner_FR".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Doorcard_FR".apply_deformation(Vector3(5, 1, 55), 1, 25)
		$"doge-body/Doorglass_FR".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		$"doge-body/Stear".apply_deformation(Vector3(5, 1, 55), 0.5, 25)
		
		#$"doge-body/Body".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Grill".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Hood".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Door_FL".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Trunkdoor".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Doorglass_FL".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Windshield".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Hood_inner".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Taillights".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Suspension_front".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Bottom".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Taillights_glass_reverse".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Headlights_glass".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Turnsignals_glass".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Badges_body".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Badges_hood".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Exhaust".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Numberplate_rear".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Dashboard".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Seats".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Doorcard_FL".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Door_inner_FL".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Trunkdoor_inner".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Engine_Plarts_muscle".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Taillights_glass_brakelights".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Glass_rear".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Door_FR".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Door_inner_FR".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Doorcard_FR".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Doorglass_FR".deform_mesh(Vector3(5, 1, 15))
		#$"doge-body/Stear".deform_mesh(Vector3(5, 1, 15))
		
		
		
func process_accel(delta):
	if Input.is_action_pressed("W"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		if fwd_mps >= -1:
			if speed < 30 and speed != 0:
				engine_force = clamp(engine_force_value * 10 / speed, 0, 300)
			else:
				engine_force = engine_force_value
		return
	
	if Input.is_action_pressed("S"):
	# Increase engine force at low speeds to make the initial acceleration faster.
		if speed < 20 and speed != 0:
			engine_force = -clamp(engine_force_value * 3 / speed, 0, 300)
		else:
			engine_force = -engine_force_value
		return
	
	engine_force = 0
	brake = 0	

func process_steer(delta):
	steer_target = Input.get_action_strength("A") - Input.get_action_strength("D")
	steer_target *= STEER_LIMIT
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)

func process_brake(delta):
	if Input.is_action_pressed("ui_select"):
		brake=0.5
		$wheel_rear_left.wheel_friction_slip=2
		$wheel_rear_right.wheel_friction_slip=2
	else:
		$wheel_rear_left.wheel_friction_slip=2.9
		$wheel_rear_right.wheel_friction_slip=2.9
		
	


func traction(speed):
	apply_central_force(Vector3.DOWN*speed)

#func _on_body_entered(body):
	#print("dick")
	#if body.name == "Wall" or body.name.begins_with("Obstacle"):
		#print("dick")
		#var impact_point = global_transform.origin  # можно уточнить через `get_collision_point()` из `PhysicsDirectBodyState`
		#var impact_force = linear_velocity.length() / 10.0  # сила удара зависит от скорости
#
		#if has_node("BodyDeform"):
			#$BodyDeform.apply_deformation(impact_point, impact_force, 1.5)


#func _on_area_3d_body_entered(body: Node3D) -> void:
	#print(body.name)
	##print(body.is_in_group("Obstacle"))
	##if body.is_in_group("Obstacle"):
		##print("fuck")
	#if body.name == "Wall" or body.name.begins_with("Obstacle"):
		#var impact_point = global_transform.origin  # можно уточнить через `get_collision_point()` из `PhysicsDirectBodyState`
		#var impact_force = linear_velocity.length() / 2.0  # сила удара зависит от скорости
		#print(impact_point, impact_force)
		#
		#if has_node("BodyDeform"):
			#print(impact_point, impact_force)
			#$"doge-body/Body".apply_deformation(impact_point, impact_force, 1.5)
			#

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Wall" or body.name.begins_with("Obstacle"):
		# Определяем примерную точку столкновения — разницу между объектами
		var impact_point_world = body.global_transform.origin
		var impact_point_local = $"doge-body/Body".to_local(impact_point_world)

		var impact_force = linear_velocity.length() / 2.0
		print(impact_point_local, impact_force)
		
		if has_node("doge-body/Body"):
			$"doge-body/Body".apply_deformation(impact_point_local, 0.7, 25)
