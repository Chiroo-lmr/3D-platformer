extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var anim_player = $AnimationPlayer
	anim_player.play("fly")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
