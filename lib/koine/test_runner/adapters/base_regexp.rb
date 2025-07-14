require_relative './base_adapter'
module Koine
  class TestRunner
    class Adapters
      class BaseRegexp < BaseAdapter
        def initialize(file_pattern:)
          @file_pattern = file_pattern.is_a?(Regexp) ? file_pattern : Regexp.new(file_pattern)
        end

        private

        def accept?(config)
          !@file_pattern.match(config.file_path).nil?
        end
      end
    end
  end
end
