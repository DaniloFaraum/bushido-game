extends CharacterBody2D

@export var speed: float = 300
@export var playerNum: int
@export var coldownThreshold: int = 50
@export var maxHealth: float = 100
@export var currentHealth: float = maxHealth
var cooldownTimer: int = 0
@export var parrySpeedMultiplier: float = 1.5
@export var parryDamageMultiplier: float = 1.5
@export var parryColdownThreshold: int = 30 #quanto maior mais demorado
var parryCooldownTimer: int = 0

var bullet = preload("res://scenes/bullet.tscn")
var bulletOffset = Vector2(80,10)

func _ready():
	playerSet()
	
	

func _process(delta):
	handleCooldown(delta)

func _physics_process(delta):
	move_and_collide(velocity * delta)
	movement(delta)
	skills()

func handleCooldown(delta):
	if cooldownTimer < coldownThreshold:
		cooldownTimer += int(100 * delta)
	if parryCooldownTimer < parryColdownThreshold:
		parryCooldownTimer += int(100 * delta)
	

func movement(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed('up_p' + str(playerNum)):
		velocity.y -= speed
	if Input.is_action_pressed('down_p' + str(playerNum)):
		velocity.y += speed

func simpleAttack():
	var bulletInstace = bullet.instantiate()
	bulletInstace.position = position + bulletOffset
	bulletInstace.initialize(playerNum)
	get_parent().add_child(bulletInstace)
	cooldownTimer = 0

func skills():
	if Input.is_action_just_pressed("atk_p" + str(playerNum)) and cooldownTimer == coldownThreshold:
		$AnimationPlayer.play('attack') 
	if Input.is_action_just_pressed("parry_p" + str(playerNum)) and parryCooldownTimer == parryColdownThreshold:
		$AnimationPlayer.play('parry_windup')
		parryCooldownTimer = 0

func playerSet():
	if playerNum == 2:
		self.scale = Vector2(-1,1)
		bulletOffset.x *= -1


func _on_parry_area_area_entered(area):
	var bullet = area.get_parent()
	if bullet.playerOwner != playerNum:
		bullet.playerOwner = playerNum
		bullet.velocity *= parrySpeedMultiplier
		bullet.parriedTimes += 1
		bullet.damage *= parryDamageMultiplier
		var parryTimes = bullet.getParriedTimes()
		$AudioStreamPlayer2D.playParry(parryTimes)
	

func handleHealth(value, type):
	if type == 'damage':
		currentHealth -= value
		$AnimationPlayer.play('damaged')
		if currentHealth <= 0:
			deabilitate()
			$AnimationPlayer.play('death')
	if type == 'heal':
		currentHealth -= value
	
func deabilitate():
	set_process(not is_processing())
	parryCooldownTimer = 0
	cooldownTimer = 0


func _on_card_ui_reset_match():
	print('chegou')
	set_process(is_processing())
	currentHealth = maxHealth
	$AnimationPlayer.play('idle')
	
func setWinner():
	if playerNum == 1:
		Winner.winner = 2
	if playerNum == 2:
		Winner.winner = 1
	get_tree().change_scene_to_file("res://scenes/Dead.tscn")
