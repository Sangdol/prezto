if [[ "$OSTYPE" != darwin* ]]; then
  return 1
fi

# Get Screen Shot
# - Move the latest screen shot file to current location
gss() {
	local ss_path=$(defaults read com.apple.screencapture location)
	local latestFile="$(ls -t $ss_path | head -1)"
	mv "$ss_path/$latestFile" .
}
