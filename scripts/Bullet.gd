extends Node2D


@export var velocity: int = 500
var playerOwner: int
var parriedTimes: float = 0
@export var damage = 10

func _ready():
	pass

func _process(delta):
	parryDetection()
	bulletMovement(delta)

func initialize(num: int):
	playerOwner = num

func bulletMovement(delta):
	if playerOwner == 1:
		position.x += velocity * delta
	if playerOwner == 2:
		position.x -= velocity * delta
		
func getParriedTimes():
	return parriedTimes

func parryDetection():
	if parriedTimes >= 1:
		$CPUParticles2D.emitting = true
	if parriedTimes > 2:
		$CPUParticles2D.color= Color(10, 1, 1, 1)#b20026

func _on_area_2d_body_entered(body):
	if body.get_collision_layer_value(1) and body.playerNum: #player
		#body.queue_free()
		body.handleHealth(damage, 'damage')
		queue_free()
	if body.get_collision_layer_value(3): #worldBorder
		queue_free()
