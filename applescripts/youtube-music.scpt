on currentMusic()
  if application "Google Chrome Canary" is running then
    tell application "Google Chrome Canary"
      repeat with t in tabs of windows
        tell t
          if URL starts with "https://music.youtube.com/" then
            set playPauseButtonStatus to execute javascript "document.querySelector('#play-pause-button').getAttribute('aria-label')"

            if playPauseButtonStatus is "Play" then
              set playButton to "► "
            else
              set playButton to ""
            end if

            set musicTitle to execute javascript "document.querySelector('.content-info-wrapper.ytmusic-player-bar yt-formatted-string > *').innerText"
            set artist to execute javascript "document.querySelector('.subtitle.ytmusic-player-bar yt-formatted-string > *').innerText"

            set likeStatus to execute javascript "document.querySelector('.middle-controls-buttons paper-icon-button.like').getAttribute('aria-pressed')"
            if likeStatus is "true" then
              set likeIcon to " ∙ "
            else
              set likeIcon to "  "
            end if

            if musicTitle is missing value then
              return ""
            else
              return playButton & musicTitle & likeIcon & artist
            end if
          end if
        end tell
      end repeat
    end tell
  end if
  return ""
end currentMusic

return currentMusic()
