module Koine
  class TestRunner
    class Adapters
      class Rspec
        def initialize(file_pattern: /.*_spec.rb$/)
          @file_pattern = file_pattern.is_a?(Regexp) ? file_pattern : Regexp.new(file_pattern)
        end

        def accept?(file_path:)
          !@file_pattern.match(file_path).nil?
        end

        def test_command(file_path:, line: nil, all_tests: false)

        end

        def command_for_file_test(file_path:, line:)
        end

        def command_for_single_test(file_path:, line:)
        end

        def command_for_all_tests(file_path:)
        end
      end
    end
  end
end
