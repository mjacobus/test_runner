module Koine
  class TestRunner
    class Adapters
      class Rspec
        def initialize(file_pattern: /.*_spec.rb$/)
          @file_pattern = file_pattern.is_a?(Regexp) ? file_pattern : Regexp.new(file_pattern)
        end

        def accept?(config)
          !@file_pattern.match(config.file_path).nil?
        end

        def test_command(config)
          return script if config.all?

          file = config.file_path

          if config.line?
            file += ':' + config.line.to_s
          end

          [script, file].join(' ')
        end

        private

        def script
          'bundle exec rspec'
        end

      end
    end
  end
end
