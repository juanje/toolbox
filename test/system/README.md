# System tests

These tests are built with BATS (Bash Automated Testing System).

The tests are meant to ensure that Toolbox's functionality remains stable
throughout updates of both Toolbox and Podman/libpod.

## WARNING

Running the tests will clear all podman state (delete all containers, images etc). This is done to ensure the results of test results are reproducible. TODO: there must be a better way.

## Dependencies

Running the tests requites that `bats`, `podman`, and `skopeo` are installed on your system. Additionally these tests use a few libraries for BATS. In order to use it you need to download them to the `libs`
directory:

```
# Go to the Toolbox root folder
$ git clone https://github.com/ztombol/bats-assert test/system/libs/bats-assert
$ git clone https://github.com/ztombol/bats-support test/system/libs/bats-support
```

## Convention

- All tests should follow the nomenglature: "[command]: Try to...".
- When the test is expected to fail or give a non obvious output, it should be put in parentesis at the end of the title.

Examples:
* `@test "create: Try to create the default container"`
* `@test "rm: Try to remove a non-existent container (it should fail)"`


- All the tests start with a clean system (no images or containers) to make sure
that there are no dependencies between tests and they are really isolated. Use the `setup()` and `teardown()` functions for that purpose.

## How to run the tests

Make sure you have `bats`, `podman`, `toolbox` and `skopeo` installed on your system.

- Enter the toolbox root folder
- Prepare container images. See [playbooks/toolbox-mock-images.yml](../../playbooks/toolbox-mock-images.yml)
- Invoke command `bats ./test/system/` and the test suite should fire up

By default the test suite uses the system versions of `podman` and `toolbox`.

If you have a `podman` or `toolbox` installed in a nonstandard location then
you can use the `PODMAN` and `TOOLBOX` environmental variables to set the path
to the binaries. So the command to invoke the test suite could look something
like this: `PODMAN=/usr/libexec/podman TOOLBOX=./toolbox bats ./test/system/`.
