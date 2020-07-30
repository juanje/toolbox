#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load 'libs/helpers'

setup() {
  cleanup_all
}

teardown() {
  cleanup_all
}


@test "Run list with zero containers and zero images" {
  run toolbox list

  assert_success
  assert_output ""
}

@test "Run list with zero containers (-c flag)" {
  run toolbox list -c

  assert_success
  assert_output ""
}

@test "Run list with zero images (-i flag)" {
  run toolbox list -c

  assert_success
  assert_output ""
}

@test "Run list with zero toolbox's containers and images, but other image" {
  get_busybox_image

  run podman images

  assert_output --partial "$BUSYBOX_IMAGE"

  run toolbox list

  assert_success
  assert_output ""
}

@test "Run list with three containers and two images" {
  # Pull the two images
  pull_default_image
  pull_image 29
  # Create tree containers
  create_default_container
  create_container non-default-one
  create_container non-default-two

  # Check images
  run toolbox list --images

  assert_success
  assert_output --partial "fedora-toolbox:${DEFAULT_FEDORA_VERSION}"
  assert_output --partial "fedora-toolbox:29"

  # Check containers
  run toolbox list --containers

  assert_success
  assert_output --partial "fedora-toolbox-${DEFAULT_FEDORA_VERSION}"
  assert_output --partial "non-default-one"
  assert_output --partial "non-default-two"

  # Check all together
  run toolbox list

  assert_success
  assert_output --partial "fedora-toolbox:${DEFAULT_FEDORA_VERSION}"
  assert_output --partial "fedora-toolbox:29"
  assert_output --partial "fedora-toolbox-${DEFAULT_FEDORA_VERSION}"
  assert_output --partial "non-default-one"
  assert_output --partial "non-default-two"
}
