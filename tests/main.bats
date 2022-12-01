#!/usr/bin/env bats


@test "fuse is installed" {
  run docker run --rm --pull never --entrypoint sh $IMAGE -c \
    'which fusermount'
  [ "$status" -eq 0 ]
}

@test "fuse runs ok" {
  run docker run --rm --pull never --entrypoint sh $IMAGE -c \
    'fusermount -V'
  [ "$status" -eq 0 ]
}


@test "SSH is installed" {
  run docker run --rm --pull never --entrypoint sh $IMAGE -c \
    'which ssh'
  [ "$status" -eq 0 ]
}

@test "SSH runs ok" {
  run docker run --rm --pull never --entrypoint sh $IMAGE -c \
    'ssh -V'
  [ "$status" -eq 0 ]
}


@test "rclone is installed" {
  run docker run --rm --pull never --entrypoint sh $IMAGE -c \
    'which rclone'
  [ "$status" -eq 0 ]
}

@test "rclone runs ok" {
  run docker run --rm --pull never --entrypoint sh $IMAGE -c \
    'rclone --help'
  [ "$status" -eq 0 ]
}


@test "restic is installed" {
  run docker run --rm --pull never --entrypoint sh $IMAGE -c \
    'which restic'
  [ "$status" -eq 0 ]
}

@test "restic runs ok" {
  run docker run --rm --pull never $IMAGE --help
  [ "$status" -eq 0 ]
}

@test "restic has correct version" {
  run sh -c 'grep "ARG restic_ver=" Dockerfile | cut -d= -f2 | tr -d "\n"'
  [ "$status" -eq 0 ]
  [ ! "$output" = '' ]
  expected="$output"

  run docker run --rm --pull never --entrypoint sh $IMAGE -c \
    "restic version | grep -i 'restic $expected'"
  [ "$status" -eq 0 ]
}
