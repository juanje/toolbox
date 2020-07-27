#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "Show usage screen when no command is given" {
  run toolbox

  assert_failure
  assert_line --index 0 "Error: missing command"
  assert_output --partial "Run 'toolbox --help' for usage."
}

@test "Show usage screen when command help is given" {
  run toolbox help

  assert_success
  assert_output --partial "toolbox - Unprivileged development environment"
}

@test "Show usage screen when flag --help is given" {
  run toolbox --help

  assert_success
  assert_output --partial "toolbox - Unprivileged development environment"
}