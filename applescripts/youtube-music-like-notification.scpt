property youtubeMusic : load script POSIX file "/Users/hugh/.zprezto/applescripts/youtube-music-compiled.scpt"
property youtubeMusicLike : load script POSIX file "/Users/hugh/.zprezto/applescripts/youtube-music-like-compiled.scpt"

on currentMusic()
  tell youtubeMusic
      return currentMusic()
  end tell
end currentMusic

on like()
  tell youtubeMusicLike
      return like()
  end tell
end currentMusic

like()

display notification currentMusic() with title "Youtube Music Liked"
