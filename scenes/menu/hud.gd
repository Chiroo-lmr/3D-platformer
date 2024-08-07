extends CanvasLayer

@onready var coins = $VBoxContainer/coins
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Global.coins_collected:
		coins.text = "Coins récupérés : " + str(Global.coins_collected)
