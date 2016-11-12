tell application "iTunes"
	set startTime to start of current track
	set endTime to duration of current track
	set fileLocation to location of current track
end tell

tell application "Finder"
	set songPath to POSIX path of fileLocation
	set formattedSongPath to POSIX file songPath as text
	set savePath to (characters 1 through ((length of formattedSongPath) - 3) of formattedSongPath) & "m4a" as text
	tell application "QuickTime Player"
		run
		open fileLocation
		trim document 1 from startTime to endTime
		set newDoc to last item of (documents whose name contains "Untitled")
		export newDoc in file savePath using settings preset "Audio Only"
		delay
		do shell script "killall \"QuickTime Player\""
	end tell
end tell

tell application "iTunes"
	set start of current track to 0
end tell