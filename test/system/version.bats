#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "version: Try flag --version (it should show the version number)" {
  run toolbox --version

  assert_output --regexp '^toolbox version [0-9]+\.[0-9]+\.[0-9]+$'
}
