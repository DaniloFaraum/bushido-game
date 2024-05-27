extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	play("idle") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playIdle():
	play("idle")
	
func playParry():
	play("parry")
