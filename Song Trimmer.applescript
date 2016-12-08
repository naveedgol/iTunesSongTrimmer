tell application "iTunes"
	if selection = {} then
		display dialog "No track selected" buttons {"Ok"} with icon caution
		error number -128
	end if
	if kind of selection = {"MPEG audio file"} then
		display dialog "Select an AAC audio file" buttons {"Ok"} with icon caution
		error number -128
	end if
	set startTime to start of selection
	set endTime to finish of selection
	set songLength to duration of selection
	set fileLocation to location of selection
	if startTime is 0 and endTime is songLength then
		display dialog "Done!" buttons {"Ok"} with icon note
		error number -128
	end if
	set start of selection to 0
	set finish of selection to songLength
end tell


tell application "Finder"
	set songPath to POSIX path of fileLocation
	set savePath to POSIX file songPath as text
	tell application "QuickTime Player"
		run
		open fileLocation
		trim document 1 from startTime to endTime
		export document 1 in file savePath using settings preset "Audio Only"
		delay 3
		do shell script "killall \"QuickTime Player\""
	end tell
end tell

display dialog "Done!" buttons {"Ok"} with icon note