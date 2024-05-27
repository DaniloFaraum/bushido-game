extends AudioStreamPlayer2D

var slashes = ["res://assets/audio/slash1.mp3", "res://assets/audio/slash2.mp3"]
var volumeChange = 50

func _ready():
	pass 


func _process(delta):
	pass

func playParryMiss():
	var buffer = FileAccess.get_file_as_bytes("res://assets/audio/miss.mp3")
	stream.data = buffer
	pitch_scale = randf_range(0.8, 1.3)
	play()

func playParry(parryTimes):
	var buffer = FileAccess.get_file_as_bytes("res://assets/audio/parry2.mp3")
	stream.data = buffer
	pitch_scale = 1.3
	if parryTimes > 1:
		pitch_scale = 1 + parryTimes/5
	play()

func playSlash():
	
	var slashSound = slashes[randi_range(0, 1)]
	var buffer = FileAccess.get_file_as_bytes(slashSound)
	stream.data = buffer
	pitch_scale = randf_range(0.8, 1.3)
	play()

	
