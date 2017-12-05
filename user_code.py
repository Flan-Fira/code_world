import cw

# edit your code with cw functions
# run() is called every step
def run():
	if (cw.get_pos_y() < 5):
		cw.press_down()
	elif (cw.get_pos_y() > 5):
		cw.press_up()
	if (cw.get_pos_x() < 9):
		cw.press_right()
	elif (cw.get_pos_x() == 9 and cw.get_pos_y() == 5):
		cw.press_right()
