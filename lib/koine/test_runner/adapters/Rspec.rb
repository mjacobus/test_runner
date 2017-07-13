module Koine
  class TestRunner
    class Adapters
      class Rspec
        def initialize(file_pattern:)
          @file_pattern = file_pattern.is_a?(Regexp) ? file_pattern : Regexp.new(file_pattern)
        end
      end
    end
  end
end
