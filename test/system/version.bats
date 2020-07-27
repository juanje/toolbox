#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "Output version number using full flag" {
  run toolbox --version

  assert_output --regexp '^toolbox version [0-9]+\.[0-9]+\.[0-9]+$'
}

@test "Output version number using command" {
  run toolbox version

  assert_line --index 0 "Error: unknown command \"version\" for \"toolbox\""
  assert_line --index 1 "Run 'toolbox --help' for usage."
}