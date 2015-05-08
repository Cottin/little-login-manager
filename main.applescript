set logins to {}

-- description, username, password
set end of logins to {"Test account manager", "manager@ourapp.com", "test98"}
set end of logins to {"Test account boss", "boss@ourapp.com", "asdqwe1"}
set end of logins to {"Test account staff", "staff@ourapp.com", "qweasdzxc"}
set end of logins to {"Business account", "john.doe@alfatech.com", "MySuperPassword"}
set end of logins to {"Private account", "john.doe@gmail.com", "SuperPassword123"}


-- to make script move slower so you can see what happens, set debugDelay to 1
set debugDelay to 0

set frontApp to (path to frontmost application as Unicode text)

-- map logins to names
set names to {}
repeat with name in logins
	set end of names to (get item 1 in name)
end repeat

activate

-- show UI with list of templates
choose from list names with title "Logins" with prompt "Choose Login:" default items (get item 1 in names)
set chosenName to result

-- http://stackoverflow.com/questions/8621290/how-to-tell-an-applescript-to-stop-executing
if chosenName is false then
	error number -128
end if

-- set chosenLogin manually. There is probably a better way to do this.
set chosenLogin to {}
set counter to 1
repeat with name in names
	-- for some reason name = chosenName does not work. Internet says string comparasion should work.. 
	if name & "STR_END" contains chosenName & "STR_END" then
		set chosenLogin to (get item counter in logins)
	end if
	set counter to counter + 1
end repeat


delay 0.2 + debugDelay

tell application frontApp
	activate
end tell

delay 0.2 + debugDelay


my stroke((get item 1 in chosenLogin))
delay 0.2 + debugDelay
tell application "System Events" to keystroke tab

my stroke((get item 2 in chosenLogin))
delay 0.2 + debugDelay
tell application "System Events" to keystroke tab

delay 0.2 + debugDelay
tell application "System Events" to keystroke return

on stroke(str)
	-- because of flash problems...
	-- http://stackoverflow.com/questions/25502830/applescript-to-keystroke-too-fast-for-flash/25505115#25505115
	set myChar to characters of str
	set myDelay to 0.01
	
	tell application "System Events"
		delay 0.2
		repeat with aChar in myChar
			keystroke aChar
			delay myDelay
		end repeat
	end tell
	
end stroke





