module Koine
  class TestRunner
    class Adapters
      class BaseRegexpAdapter
        def initialize(file_pattern:)
          @file_pattern = file_pattern.is_a?(Regexp) ? file_pattern : Regexp.new(file_pattern)
        end

        def accept?(config)
          !@file_pattern.match(config.file_path).nil?
        end

        def test_command(config)
          return all_tests(config) if config.all?
          return file_line_command(config) if config.line?
          single_file_command(config)
        end

        private

        def all_tests(config)
          script_for(config)
        end

        def file_line_command(config)
          [single_file_command(config), config.line].join(':')
        end

        def single_file_command(config)
          [script_for(config), config.file_path].join(' ')
        end

        def script_for(_config)
          raise 'Not implemented'
        end
      end
    end
  end
end
