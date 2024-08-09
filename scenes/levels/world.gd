extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
@onready var collectable = $Coin
@onready var player = $Player

func _on_coin_body_entered(body):
	if body == player:
		Global.coins_collected += 1
		if Global.coins_collected == 1:
			collectable.position = Vector3(-1, 13.5, -21)
		elif Global.coins_collected == 2:
			collectable.position = Vector3(-21, 10, -13)
		elif Global.coins_collected == 3:
			collectable.position = Vector3(1, 12.5, 1)
		elif Global.coins_collected == 4:
			collectable.position = Vector3(-7, 16.5, 11)
		elif Global.coins_collected == 5:
			collectable.position = Vector3(-1, 1, -21)
		elif Global.coins_collected == 6:
			collectable.position = Vector3(0, 1, 0)
