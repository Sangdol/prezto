on like()
  if application "Google Chrome Canary" is running then
    tell application "Google Chrome Canary"
      repeat with t in tabs of windows
        tell t
          if URL starts with "https://music.youtube.com/" then

            set likeStatus to execute javascript "document.querySelector('.middle-controls-buttons ytmusic-menu-renderer paper-icon-button.like').click()"

          end if
        end tell
      end repeat
    end tell
  end if
  return ""
end like

return like()
