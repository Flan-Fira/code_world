# code_world

User manual:

Download Code_World.exe from https://www.dropbox.com/sh/5abcqw3idghleek/AABzjBqElM1cWP3MmvqVndzna?dl=0

Make sure you have python3.6 installed on your computer and it is in your PATH environment variable

Run Code_World.exe

Possible functions to use:
<dl>
	<dt>cw.press_up()</dt>
	<dt>cw.press_down()</dt>
	<dt>cw.press_left()</dt>
	<dt>cw.press_right()</dt>
	<dt>cw.press_use_arrow()</dt>
		<dd>User can call these to press a virtual button input for the bot</dd>
	<dt>cw.get_pos_x()</dt>
	<dt>cw.get_pos_y()</dt>
		<dd>gets the position of the bot in the current room</dd>
	<dt>cw.get_room_x()</dt>
	<dt>cw.get_room_y()</dt>
		<dd>gets the x and y coordinates of the current room in the floor</dd>
	<dt>bool cw.get_enemy_at(x, y)</dt>
		<dd>determines if there is an enemy on the tile of the (x, y) coordinates of the room</dd>
	<dt>bool cw.get_door(dir)</dt>
		<dd>determines if there is a door in the current room in the specified direction. Takes "u", "d", "l", or "r" as dir</dd>
	<dt>bool cw.get_door_room(str dir, x, y)</dt>
		<dd>determines if there is a door in the specified (x, y) room in the specified direction. Takes "u", "d", "l", or "r" as dir</dd>
</dl>