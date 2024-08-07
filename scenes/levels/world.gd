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
		collectable.position.x = randi_range(-25, 25)
		collectable.position.z = randi_range(-25, 25)
