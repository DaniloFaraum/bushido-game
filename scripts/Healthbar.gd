extends TextureProgressBar

@export var player: CharacterBody2D
@onready var maxHealth = player.maxHealth
@onready var currentHealth = player.currentHealth : set = _set_currentHealth

func _ready():
	value = maxHealth

func _process(delta):
	currentHealth = player.currentHealth

func _set_currentHealth(change):
	if currentHealth <= 0:
		value = 0
		change = 0
	currentHealth = change
	create_tween().tween_property(self, "value", currentHealth, 0.1)

