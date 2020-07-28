#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load 'libs/helpers'

# It seems like 'toolbox run' (or 'enter') doesn't work fine when
# the workdir is outside the $HOME.
# This hack is to make the tests work from outside the $HOME.
readonly CURDIR=$PWD

setup() {
  cd "$HOME" || return 1
  cleanup_containers
}

teardown() {
  cleanup_containers
  cd "$CURDIR" || return 1
}


@test "Echo 'Hello World' with no containers created (should fail)" {
  run toolbox run echo "Hello World"

  assert_failure
  assert_line --index 0 --regexp 'Error: container .* not found'
  assert_output --partial "Run 'toolbox --help' for usage."
}

#TODO: This should work without --partial
# The issue here is that toolbox output add the CRLF character at the end
@test "Echo 'Hello World' inside of the default container" {
  create_default_container

  run toolbox run echo "Hello World"

  assert_success
  assert_output --partial "Hello World"
}

@test "Echo 'Hello World' inside of the 'running' container" {
  create_container running

  run toolbox run --container running echo -n "Hello World"

  assert_success
  assert_output --partial "Hello World"
}

@test "Echo 'Hello World' again in the 'running' container after being stopped and exit" {
  create_container running
  stop_container running

  run toolbox run --container running echo -n "Hello World"

  assert_success
  assert_output --partial "Hello World"
}
