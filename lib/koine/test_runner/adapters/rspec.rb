# frozen_string_literal: true

module Koine
  class TestRunner
    class Adapters
      class Rspec < BaseRegexp
        def initialize(file_pattern: /.*_spec.rb$/)
          super(file_pattern: file_pattern)
        end

        private

        def script_for(_config)
          return './bin/rspec' if File.exist?('bin/rspec')

          'bundle exec rspec'
        end
      end
    end
  end
end
