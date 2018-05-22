#!/usr/bin/env bats


@test "post_push hook is up-to-date" {
  run sh -c "cat Makefile | grep 'TAGS ?= ' | cut -d ' ' -f 3"
  [ "$status" -eq 0 ]
  [ ! "$output" = '' ]
  expected="$output"

  run sh -c "cat hooks/post_push | grep 'for tag in' \
                                 | cut -d '{' -f 2 \
                                 | cut -d '}' -f 1"
  [ "$status" -eq 0 ]
  [ ! "$output" = '' ]
  actual="$output"

  [ "$actual" = "$expected" ]
}


@test "fuse is installed" {
  run docker run --rm --entrypoint sh $IMAGE -c 'which fusermount'
  [ "$status" -eq 0 ]
}

@test "fuse runs ok" {
  run docker run --rm --entrypoint sh $IMAGE -c 'fusermount -V'
  [ "$status" -eq 0 ]
}


@test "SSH is installed" {
  run docker run --rm --entrypoint sh $IMAGE -c 'which ssh'
  [ "$status" -eq 0 ]
}

@test "SSH runs ok" {
  run docker run --rm --entrypoint sh $IMAGE -c 'ssh -V'
  [ "$status" -eq 0 ]
}


@test "restic is installed" {
  run docker run --rm --entrypoint sh $IMAGE -c 'which restic'
  [ "$status" -eq 0 ]
}

@test "restic runs ok" {
  run docker run --rm $IMAGE --help
  [ "$status" -eq 0 ]
}

@test "restic has correct version" {
  run sh -c 'cat Makefile | grep "VERSION ?= " | cut -d " " -f 3 | tr -d "\n"'
  [ "$status" -eq 0 ]
  [ ! "$output" = '' ]
  expected="$output"

  run docker run --rm --entrypoint sh $IMAGE -c \
    "restic version | grep -i 'restic $expected'"
  [ "$status" -eq 0 ]
}
