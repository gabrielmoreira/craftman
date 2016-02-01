#!/usr/bin/env bats
. "$BATS_TEST_DIRNAME/../heroku.plugin"
DIR="$BATS_TMPDIR"

log(){
	echo "$*"
}

teardown() {
	echo "result=[$result]"
	echo "expected=[$result]"
	echo " Generated at [$HEROKU__PROCFILE] "
	rm -f "$HEROKU__PROCFILE"
}

@test "Plugin name is defined" {
	[ "$PLUGIN_NAME" = "heroku" ]
}

@test "Plugin usage contains heroku:prepare" {
	[[ "$(heroku__usage)" =~ "heroku:prepare" ]]
}

@test "Procfile path is located at project directory" {
	# given
	heroku__interpolate

	# then
	[[ "$HEROKU__PROCFILE" =~ "$BATS_TMPDIR/Procfile" ]]
}

@test "Procfile is correctly generated" {
	# given
	heroku__interpolate

	# when
	__heroku_create_procfile

	# then
	result="$(cat "$HEROKU__PROCFILE")"
	expected="web: vendor/bin/heroku-php-apache2 -i scripts/root_files/usr/local/etc/php/php.ini app/html"
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
	heroku__interpolate

	# when
	heroku__prepare

	# then
	expected="composer__prepare:composer__lock:"
	[[ "$result" == "$expected" ]]
}