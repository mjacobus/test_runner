#!/usr/bin/env bash

set -e
set -v

./exe/run_test spec/fixtures/FixturePhpUnitTest.php --line=30
./exe/run_test spec/koine/test_runner_spec.rb
./exe/run_test spec/koine/test_runner_spec.rb --line=9
./exe/run_test spec/koine/test_runner_spec.rb --all
