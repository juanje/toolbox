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


@test "rm: Try to remove a non-existent container (it should fail)" {
  container_name="nonexistentcontainer"
  run toolbox rm "$container_name"

  #assert_failure  #BUG: it should return 1
  assert_output "Error: failed to inspect container $container_name"
}

@test "rm: Try to remove a running container named 'running' (it should fail)" {
  create_container running
  start_container running

  run toolbox rm running

  #assert_failure  #BUG: it should return 1
  assert_output "Error: container running is running"
}

@test "rm: Try to remove a not running container named 'not-running'" {
  create_container not-running

  run toolbox rm not-running

  assert_success
  assert_output ""
}

@test "rm: Try to force remove the running container 'running'" {
  create_container running
  start_container running

  run toolbox rm --force running

  assert_success
  assert_output ""
}

@test "rm: Try to force remove all remaining containers (with 2 containers created and 1 running)" {
  num_of_containers=$(list_containers)
  create_container running
  create_container not-running
  start_container running

  run toolbox rm --force --all

  assert_success
  assert_output ""

  new_num_of_containers=$(list_containers)

  assert_equal "$new_num_of_containers" "$num_of_containers"
}
