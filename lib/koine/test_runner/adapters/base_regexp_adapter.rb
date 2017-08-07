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
          raise 'Not implemented'
        end
      end
    end
  end
end
