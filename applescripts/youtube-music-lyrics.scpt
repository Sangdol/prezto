if application "Google Chrome Canary" is running then
  tell application "Google Chrome Canary"
    repeat with t in tabs of windows
      tell t
        if URL starts with "https://music.youtube.com/" then

          set musicTitle to execute javascript "document.querySelector('.content-info-wrapper.ytmusic-player-bar yt-formatted-string.title').innerText"
          set artist to execute javascript "document.querySelector('.subtitle.ytmusic-player-bar yt-formatted-string > *').innerText"

          -- open location started not taking not spaces (probably not valid url)
          --open location "https://www.google.com/search?uact=5&q=lyrics%20" & artist & "%20" & musicTitle
          do shell script "open 'https://www.google.com/search?uact=5&q=lyrics " & artist & " " & musicTitle & "'"

        end if
      end tell
    end repeat
  end tell
end if
return ""
