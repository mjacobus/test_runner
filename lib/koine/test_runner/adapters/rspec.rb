module Koine
  class TestRunner
    class Adapters
      class Rspec < BaseRegexpAdapter
        def initialize(file_pattern: /.*_spec.rb$/)
          super(file_pattern: file_pattern)
        end

        def test_command(config)
          script = script_for(config)

          return script if config.all?

          file = config.file_path

          file += ':' + config.line.to_s if config.line?

          [script, file].join(' ')
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
