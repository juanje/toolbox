# System tests

These tests are built with BATS (Bash Automated Testing System).

The tests are meant to ensure that Toolbox's functionality remains stable
throughout updates of both Toolbox and Podman/libpod.

## Dependencies

These tests use a few standard libraries for BATS which help with clarity
and consistency. In order to use it you need to download them to the `libs`
directory:

```
# Go to the Toolbox root folder
$ git clone https://github.com/ztombol/bats-assert test/system/libs/bats-assert
$ git clone https://github.com/ztombol/bats-support test/system/libs/bats-support
```

## Convention

- All tests that start with *Try to..* expect non-zero return value.
- All the tests start with a clean system (no images or containers) to make sure
that there are no dependencies between tests and they are really isolated.

## How to run the tests

Make sure you have `bats` and `podman` with `toolbox` installed on your system.

- Enter the toolbox root folder
- Invoke command `bats ./test/system/` and the test suite should fire up

By default the test suite uses the system versions of `podman` and `toolbox`.

If you have a `podman` or `toolbox` installed in a nonstandard location then
you can use the `PODMAN` and `TOOLBOX` environmental variables to set the path
to the binaries. So the command to invoke the test suite could look something
like this: `PODMAN=/usr/libexec/podman TOOLBOX=./toolbox bats ./test/system/`.
