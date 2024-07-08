extends CanvasLayer


@onready var wood_label: Label = $WoodLabel
@onready var food_label: Label = $FoodLabel

func _process(_delta):
	wood_label.text = "Wood: " + str(Game.Wood)
	food_label.text = "Food: " + str(Game.Food)
