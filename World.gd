extends Node

var score = 0 setget set_score

onready var scoreLabel = $ScoreLabel
onready var hearts = $Hearts

func _ready():
	_update_hearts()

func set_score(value):
	score = value
	update_score_label()

func update_score_label():
	scoreLabel.text = "Score = " + str(score)

func update_save_data():
	var save_data = SaveAndLoad.load_data_from_file()
	if score > save_data.highscore:
		save_data.highscore = score
		SaveAndLoad.save_data_to_file(save_data)

func _on_Ship_player_death():
	update_save_data()
	yield(get_tree().create_timer(1), "timeout")
	var _r = get_tree().change_scene("res://GameOverScreen.tscn")

func _update_hearts():
	var count = hearts.get_child_count()
	print("nuber of hearts = " + str(count))
