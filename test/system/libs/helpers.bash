#!/usr/bin/env bash

readonly BUSYBOX_IMAGE="docker.io/library/busybox"


function cleanup_all() {
  podman system reset --force >/dev/null
}


function cleanup_containers() {
  podman rm --all --force >/dev/null
}


function get_busybox_image() {
  podman pull "$BUSYBOX_IMAGE" >/dev/null \
    || echo "Podman couldn't pull the image."
}


function create_default_container() {
  toolbox --assumeyes create >/dev/null \
    || echo "Toolbox couldn't create the default container"
}


function create_container() {
  local container_name
  container_name="$1"

  toolbox --assumeyes create --container "$container_name" >/dev/null \
    || echo "Toolbox couldn't create the container '$container_name'"
}


function start_container() {
  local container_name
  container_name="$1"

  podman start "$container_name" >/dev/null \
    || echo "Podman couldn't start the container '$container_name'"
}


function stop_container() {
  local container_name
  container_name="$1"

  podman stop "$container_name" >/dev/null \
    || echo "Podman couldn't stop the container '$container_name'"
}


function list_images() {
  podman images --all --quiet | wc -l
}


function list_containers() {
  podman ps --all --quiet | wc -l
}
