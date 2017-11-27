extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var interpreter

func _ready():
	interpreter = Interpreter.new()



func _on_Init_button_down():
	var editor = get_node("TextEdit")
	var code = editor.get_text()
	interpreter.init(code)


func _on_Run_button_down():
	interpreter.run()


func _on_Finalize_button_down():
	interpreter.finalize()
