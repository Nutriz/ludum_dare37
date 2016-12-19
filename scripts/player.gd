# Copyright (c) 2015 Calinou
# This source code form is governed by the MIT license.
# See LICENSE.md for more information.

extends RigidBody

var view_sensitivity = 0.20
var yaw = 0
var pitch = 0
var is_moving = false

const max_accel = 0.005
const air_accel = 0.02

var timer = 0

var walk_speed = 3.5
var jump_speed = 3

var ray_length = 20

func _ready():
	set_process_input(true)

	# Capture mouse once game is started:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	set_fixed_process(true)
	get_node("Crosshair").set_text("+")
	
func moveCamera(event):
	yaw = fmod(yaw - event.relative_x * view_sensitivity, 360)
	pitch = max(min(pitch - event.relative_y * view_sensitivity, 85), -85)
	get_node("Yaw").set_rotation(Vector3(0, deg2rad(yaw), 0))
	get_node("Yaw/Camera").set_rotation(Vector3(deg2rad(pitch), 0, 0))

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		moveCamera(event)

	if event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index==1:
		shoot(event)

func shoot(event):
		get_node("Yaw/Camera/ShotSound").play("blop")
		var camera = get_node("Yaw/Camera")
		var screensize = get_viewport().get_rect().size
		var from = camera.project_position(Vector2(screensize.x/2, screensize.y/2))
#		var from = camera.project_position(Vector2(screensize.x/2 + 300, screensize.y + 800))

#		print("from", from)
		var to = camera.project_ray_normal(screensize/2) * ray_length

		var newBallScene = preload("res://scenes/ball.tscn")
		var newBall = newBallScene.instance()
		newBall.set_translation(from)
		newBall.apply_impulse(from, to)
		
		var world = get_node("/root/World")
		world.add_child(newBall)
		
func _fixed_process(delta):
	get_node("FPS").set_text(str(OS.get_frames_per_second(), " FPS"))
	is_moving = false


func _integrate_forces(state):
	var aim = get_node("Yaw").get_global_transform().basis
	var direction = Vector3()

	if Input.is_action_pressed("move_forwards"):
		direction -= aim[2]
		is_moving = true
	if Input.is_action_pressed("move_backwards"):
		direction += aim[2]
		is_moving = true
	if Input.is_action_pressed("move_left"):
		direction -= aim[0]
		is_moving = true
	if Input.is_action_pressed("move_right"):
		direction += aim[0]
		is_moving = true

	direction = direction.normalized()
	var ray = get_node("Ray")

	if ray.is_colliding():
		var normal = ray.get_collision_normal()
		var floor_velocity = Vector3()
		var object = ray.get_collider()

		if object extends RigidBody or object extends StaticBody:
			var point = ray.get_collision_point() - object.get_translation()
			var floor_angular_vel = Vector3()
			if object extends RigidBody:
				floor_velocity = object.get_linear_velocity()
				floor_angular_vel = object.get_angular_velocity()
			elif object extends StaticBody:
				floor_velocity = object.get_constant_linear_velocity()
				floor_angular_vel = object.get_constant_angular_velocity()
			# Surely there should be a function to convert Euler angles to a 3x3 matrix
			var transform = Matrix3(Vector3(1, 0, 0), floor_angular_vel.x)
			transform = transform.rotated(Vector3(0, 1, 0), floor_angular_vel.y)
			transform = transform.rotated(Vector3(0, 0, 1), floor_angular_vel.z)
			floor_velocity += transform.xform_inv(point) - point
			yaw = fmod(yaw + rad2deg(floor_angular_vel.y) * state.get_step(), 360)
			get_node("Yaw").set_rotation(Vector3(0, deg2rad(yaw), 0))

		var diff = floor_velocity + direction * walk_speed - state.get_linear_velocity()
		var vertdiff = aim[1] * diff.dot(aim[1])
		diff -= vertdiff
		diff = diff.normalized() * clamp(diff.length(), 0, max_accel / state.get_step())
		diff += vertdiff

		apply_impulse(Vector3(), diff * get_mass())

		if Input.is_action_pressed("jump"):
			apply_impulse(Vector3(), normal * jump_speed * get_mass())
			get_node("Yaw/Camera/ShotSound").play("jump")

	else:
		apply_impulse(Vector3(), direction * air_accel * get_mass())

	state.integrate_forces()

func _exit_scene():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
