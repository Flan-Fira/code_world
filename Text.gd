extends TextEdit
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var interpreter

func _ready():
	interpreter = Interpreter.new()
	pass

func _on_int_pressed():
	var code = get_text()
	interpreter.init(code)
	pass # replace with function body


func _on_run_pressed():
	interpreter.run()
	pass # replace with function body

func _on_Button_pressed():
	interpreter.finalize()
	pass # replace with function body


func _on_final_pressed():
	pass # replace with function body
