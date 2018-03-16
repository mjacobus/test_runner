#!/usr/bin/env bash

set -e
set -v

export SKIP_COVERAGE='true'

./exe/run_test spec/fixtures/FixturePhpUnitTest.php --line=30
./exe/run_test spec/koine/test_runner_spec.rb
./exe/run_test spec/koine/test_runner_spec.rb --line=9
./exe/run_test spec/koine/test_runner_spec.rb --last
./exe/run_test spec/koine/test_runner_spec.rb --all
