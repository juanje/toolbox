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


@test "create: Create the default container" {
  pull_default_image

  run toolbox -y create

  assert_success
}

@test "create: Create a container with a valid custom name ('custom-containerName')" {
  run toolbox -y create -c "custom-containerName"

  assert_success
}

@test "create: Create a container with a custom image and name ('fedora29';f29)" {
  pull_image 29

  run toolbox -y create -c "fedora29" -i fedora-toolbox:29

  assert_success
}

@test "create: Try to create a container with invalid custom name ('ßpeci@l.Nam€')" {
  run toolbox -y create -c "ßpeci@l.Nam€"

  assert_failure
  assert_output "Error: failed to create container ßpeci@l.Nam€"
}
