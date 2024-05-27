extends Control

signal resetMatch

@export var card: Card

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/TextureRect.texture = card.image
	$Panel/Title.text = card.name
	$Panel/Desc.text = card.description


func _process(delta):
	pass


func _on_pressed():
	checkCardEffect()
	get_parent().get_parent().visible = false
	resetMatch.emit()
	print(resetMatch)
	

func checkCardEffect():
	var eff = card.effect
	var amnt = card.ammount
	var player = get_parent().get_parent().get_parent()
	
	if eff == 'speed': player.speed += amnt
	if eff == 'maxHealth': player.maxHealth += amnt
