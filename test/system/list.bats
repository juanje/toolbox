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


@test "Run list with zero containers and images" {
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
