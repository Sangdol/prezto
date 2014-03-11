if [[ "$OSTYPE" != darwin* ]]; then
  return 1
fi

# Get Screen Shot
# - Move the latest screen shot file to current location
get-ss() {
	local ss_path=$(defaults read com.apple.screencapture location)
	local latestFile="$(ls -t $ss_path | head -1)"

	if [ $latestFile ]; then
		mv "$ss_path/$latestFile" .
	else
		echo "There's no file in $ss_path"
	fi
}

# Etc
alias chrome="/usr/bin/open -a \"$HOME/Applications/Google Chrome.app\""
