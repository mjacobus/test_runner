module Koine
  class TestRunner
    class Adapters
      class Rspec < BaseRegexpAdapter
        def initialize(file_pattern: /.*_spec.rb$/)
          super(file_pattern: file_pattern)
        end

        private

        def all_tests(config)
          script_for(config)
        end

        def file_line_command(config)
          file = config.file_path
          file += ':' + config.line.to_s
          [script_for(config), file].join(' ')
        end

        def single_file_command(config)
          file = config.file_path
          file += ':' + config.line.to_s if config.line?

          [script_for(config), file].join(' ')
        end

        def script_for(_config)
          return './bin/rspec' if File.exist?('bin/rspec')

          'bundle exec rspec'
        end
      end
    end
  end
end
