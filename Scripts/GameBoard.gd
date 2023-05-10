extends Control

func _ready():
	for i in get_child(1).get_child(0).get_children():
		for y in i.get_children():
			y.toggle_mode = true
			y.pressed.connect(on_board_button_pressed.bind(y))

func on_board_button_pressed(y):
	if y.button_pressed:
		if multiplayer.get_unique_id() == 1:
			y.text = "X"
			rpc("pass_message", "X")
		else:
			y.text = "O"
			rpc("pass_message", "0")
		
@rpc
func pass_message(message):
	print(str(multiplayer.get_unique_id()) + message)
