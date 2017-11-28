extends Node2D



# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _on_Undo_press():
	# undos the last line written
	get_node("TextEdit").undo()
	
	pass

func _on_Clear_press():
	# clears the text editor
	get_node("TextEdit").set_text("")
	
	pass
	
func _on_Submit_press():
	# creates a file containing the code, and returns the string with all the inputs
	var file = File.new()
	var file_name = "user://code_input.txt"
	var input = get_node("TextEdit").get_text()
	
	file.open(file_name, File.WRITE)
	file.store_string(input)
	file.close()

	return input

	pass


func _ready():
	get_node("Undo").connect("pressed",self,"_on_Undo_press")
	get_node("Clear").connect("pressed",self,"_on_Clear_press")
	get_node("Submit").connect("pressed",self,"_on_Submit_press")
	
	pass