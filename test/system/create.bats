#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load 'libs/helpers'

setup() {
  cleanup_containers
}

teardown() {
  cleanup_containers
}


@test "Create the default container" {
  run toolbox -y create

  assert_success
}

@test "Create a container with a valid custom name ('not-running')" {
  run toolbox -y create -c "not-running"

  assert_success
}

@test "Create a container with a custom image and name ('running';f29)" {
  run toolbox -y create -c "running" -i fedora-toolbox:29

  assert_success
}

@test "Try to create a container with invalid custom name" {
  run toolbox -y create -c "ßpeci@l.Nam€"

  assert_output "Error: failed to create container ßpeci@l.Nam€"
}
