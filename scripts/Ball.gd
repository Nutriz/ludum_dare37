extends RigidBody

var acceptedColor = Color(0.0, 0.8, 0.2)
var blockedColor = Color("#950000")

func _ready():
	var mat = get_node("mesh").get_material_override().duplicate()
	mat.set_parameter(FixedMaterial.PARAM_DIFFUSE, blockedColor)
	get_node("mesh").set_material_override(mat)

func _on_Ball_body_enter_shape( body_id, body, body_shape, local_shape ):

	if (body.get_node(".").get_name() == "FinishTrigger"):
		print("body: ", body.get_node(".").get_name())
		get_node("/root/World/finishText").show()
		
	if (body.get_node(".").get_name() == "greenTrigger"):
		get_node("mesh").get_material_override().set_parameter(FixedMaterial.PARAM_DIFFUSE, acceptedColor)
		set_collision_mask_bit(2, false)
		set_layer_mask_bit(2, false)	
		



