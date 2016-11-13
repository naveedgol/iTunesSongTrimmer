tell application "iTunes"
	set startTime to start of current track
	set endTime to finish of current track
	set songLength to duration of current track
	set fileLocation to location of current track
	if startTime is 0 and endTime is songLength then
		error number -128
	end if
	set start of current track to 0
	set finish of current track to songLength
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