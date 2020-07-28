#!/usr/bin/env bash

# Podman and Toolbox commands to run
readonly PODMAN=${PODMAN:-podman}
readonly TOOLBOX=${TOOLBOX:-toolbox}

# Helpful globals
current_os_version=$(awk -F= '/VERSION_ID/ {print $2}' /etc/os-release)
readonly DEFAULT_FEDORA_VERSION=${DEFAULT_FEDORA_VERSION:-${current_os_version}}
readonly TOOLBOX_DEFAULT_IMAGE="fedora-toolbox:${DEFAULT_FEDORA_VERSION}"
readonly REGISTRY_URL=${REGISTRY_URL:-"registry.fedoraproject.org"}
readonly BUSYBOX_IMAGE="docker.io/library/busybox"


function cleanup_all() {
  $PODMAN system reset --force >/dev/null
}


function cleanup_containers() {
  $PODMAN rm --all --force >/dev/null
}


function get_busybox_image() {
  $PODMAN pull "$BUSYBOX_IMAGE" >/dev/null \
    || echo "Podman couldn't pull the image."
}


function create_default_container() {
  toolbox --assumeyes create >/dev/null \
    || echo "Toolbox couldn't create the default container"
}


function create_container() {
  local container_name
  container_name="$1"

  $TOOLBOX --assumeyes create --container "$container_name" >/dev/null \
    || echo "Toolbox couldn't create the container '$container_name'"
}


function start_container() {
  local container_name
  container_name="$1"

  $PODMAN start "$container_name" >/dev/null \
    || echo "Podman couldn't start the container '$container_name'"
}


function stop_container() {
  local container_name
  container_name="$1"

  $PODMAN stop "$container_name" >/dev/null \
    || echo "Podman couldn't stop the container '$container_name'"
}


function list_images() {
  $PODMAN images --all --quiet | wc -l
}


function list_containers() {
  $PODMAN ps --all --quiet | wc -l
}
