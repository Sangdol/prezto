if application "Google Chrome Canary" is running then
	tell application "Google Chrome Canary"
		repeat with t in tabs of windows
			tell t
				if URL starts with "https://music.youtube.com/" then
					set pageTitle to title of t as text

					if pageTitle is not "YouTube Music" then
            execute javascript "document.querySelector('#play-pause-button').click()"
					end if

				end if
			end tell
		end repeat
	end tell
end if
return ""
