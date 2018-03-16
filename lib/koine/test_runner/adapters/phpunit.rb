module Koine
  class TestRunner
    class Adapters
      class Phpunit < BaseRegexpAdapter
        DEFAULT_OPTIONS = [
          '--color'
        ].freeze

        def initialize(file_pattern: /.*Test.php$/, options: nil)
          super(file_pattern: file_pattern)
          @options = Array(options || DEFAULT_OPTIONS)
        end

        private

        def file_line_command(config)
          regexp = /public function ([^\(]+)/
          matcher = FileMatcher.new(file_path: config.file_path)
          match = matcher.above_line(config.line, regexp: regexp)[1]
          [single_file_command(config), '--filter', "'/\\b#{match}\\b/'"].join(' ')
        end

        def script_for(_config)
          if File.exist?('vendor/bin/phpunit')
            return with_options('./vendor/bin/phpunit')
          end

          with_options('phpunit')
        end

        def with_options(script)
          [script, @options].flatten.join(' ')
        end
      end
    end
  end
end
