extends CanvasLayer

@onready var coins = $VBoxContainer/coins
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Global.coins_collected:
		coins.text = "Coins récupérés : " + str(Global.coins_collected)
		if Global.coins_collected != 7:
			time = float(time) + delta
			update_ui()


var time = Global.speedrun_time
	
func update_ui():
	# Format time with two decimal places
	var formatted_time = str(time)
	var decimal_index = formatted_time.find(".")
	
	if decimal_index > 0:
		formatted_time = formatted_time.left(decimal_index + 3)  # Take only two decimal places
	
	Global.speedrun_time = formatted_time
		
	$VBoxContainer2/Label.text = formatted_time
