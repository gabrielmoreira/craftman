#!/usr/bin/env bats

# Load heroku plugin
. "$BATS_TEST_DIRNAME/../heroku.plugin"

# Mock craftman dependencies
CM_PROJECT_PATH="$BATS_TMPDIR"
cm_log(){
	echo "$*"
}
cm_can_generate()
{
	CM_GENERATE_FILE="$1"
}

# Test heroku plugin
@test "Plugin name is defined" {
	[ "$PLUGIN_NAME" = "heroku" ]
}

@test "Plugin usage contains heroku:prepare" {
	[[ "$(heroku__usage)" =~ "heroku:prepare" ]]
}

@test "Procfile path is located at project directory" {
	# given
	heroku__config

	# then
	[[ "$HEROKU__PROCFILE" =~ "$BATS_TMPDIR/Procfile" ]]
}

@test "Procfile is correctly generated" {
	# given
	heroku__config

	# when
	__heroku_create_procfile

	# then
	result="$(cat "$HEROKU__PROCFILE")"
	expected="web: vendor/bin/heroku-php-apache2 -i scripts/override/usr/local/etc/php/php.ini app/html"
	[[ "$result" == "$expected" ]]
}

@test "heroku:prepare command is correctly working" {
	# given
	result=""
	composer__prepare() {
		result+="composer__prepare:"
	}
	composer__lock() {
		result+="composer__lock:"
	}
	heroku__config

	# when
	heroku__prepare

	# then
	expected="composer__prepare:composer__lock:"
	[[ "$result" == "$expected" ]]
}

teardown() {
	echo "result=[$result]"
	echo "expected=[$result]"
	echo " Generated at [$HEROKU__PROCFILE] "
	rm -f "$HEROKU__PROCFILE"
}