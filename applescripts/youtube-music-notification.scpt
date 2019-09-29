property youtubeMusic : load script POSIX file "/Users/hugh/.zprezto/applescripts/youtube-music-compiled.scpt"

on currentMusic()
  tell youtubeMusic
      return currentMusic()
  end tell
end currentMusic

display notification currentMusic() with title "Youtube Music"
