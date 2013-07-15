watch_build_gradle() {
	echo "--- Watch build.gradle started ---"

	watchmedo shell-command \
		--patterns="*.gradle" \
		--command="$HOME/.zprezto/modules/gradle/gradle_eclipse_and_build.sh" \
		.
}

alias ee=gradle
