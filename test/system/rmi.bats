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


@test "Remove all images with the default image present" {
  num_of_images=$(list_images)
  create_default_container
  cleanup_containers

  run toolbox rmi --all

  assert_success
  assert_output ""

  new_num_of_images=$(list_images)

  assert_equal "$new_num_of_images" "$num_of_images"
}

@test "Fail to remove all images with the default image present and running" {
  skip "The implementation need some fixes"
  num_of_images=$(list_images)
  create_container foo
  start_container foo

  run toolbox rmi --all

  #FIXME: this should fail
  #assert_failure
  #TODO: Maybe a bug -> need better error message
  assert_output "Error: the image foo is in use"

  new_num_of_images=$(list_images)

  assert_equal "$new_num_of_images" "$num_of_images"
}

@test "Remove all images with the default image present and running (with flag --force)" {
  num_of_images=$(list_images)
  create_default_container

  run toolbox rmi --all --force

  assert_success
  assert_output ""

  new_num_of_images=$(list_images)

  assert_equal "$new_num_of_images" "$num_of_images"
}
