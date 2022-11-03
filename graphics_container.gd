extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


@onready
var directional_light : DirectionalLight3D = $"../../DirectionalLight"

@onready
var world_environment : WorldEnvironment = $"../../WorldEnvironment"
func _on_shadow_check_toggled(button_pressed):
	directional_light.shadow_enabled = button_pressed

func _on_ssr_check_toggled(button_pressed):
	world_environment.environment.ssr_enabled = button_pressed

func _on_ssao_check_toggled(button_pressed):
	world_environment.environment.ssao_enabled = button_pressed

func _on_gi_check_toggled(button_pressed):
		world_environment.environment.ssil_enabled = button_pressed
		world_environment.environment.sdfgi_enabled = button_pressed
		world_environment.environment.sdfgi_use_occlusion = button_pressed

func _on_fog_check_toggled(button_pressed):
	world_environment.environment.volumetric_fog_enabled = button_pressed
