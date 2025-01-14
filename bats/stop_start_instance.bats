#!/usr/bin/env bats

load handling_conf_files.bash
load globals.bash
load_lib bats-support
load_lib bats-assert

function setup_file() {
    store_config_files
    ensureTestConfig
    deleteCache
}

function teardown_file() {
    restore_config_files
}

@test 'stop/start instance : ok' {
  run ./cntb stop instance ${REINSTALL_INSTANCE_ID}

  sleep 10

  run ./cntb start instance ${REINSTALL_INSTANCE_ID}
  assert_success
  assert_output --partial 'INSTANCEID'
  assert_output --partial 'ACTION'
  assert_output --partial "${REINSTALL_INSTANCE_ID}"
  assert_output --partial 'start'

  sleep 10

  run ./cntb stop instance ${REINSTALL_INSTANCE_ID}
}
