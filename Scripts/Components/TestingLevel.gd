extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var audio: AudioStream = preload("res://Imported Assets/Audio/Music/Aron Krogh - Heated Battle (Loop).mp3")
	SoundManager.play_music_at_volume(
		audio,
		-20.0,
		1.0,
		"Music"
	)
