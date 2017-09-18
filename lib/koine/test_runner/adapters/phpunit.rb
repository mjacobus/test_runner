module Koine
  class TestRunner
    class Adapters
      class Phpunit < BaseRegexpAdapter
        def initialize(file_pattern: /.*Test.php$/)
          super(file_pattern: file_pattern)
        end

        private

        def file_line_command(config)
          regexp = /public function ([^\(]+)/
          matcher = FileMatcher.new(file_path: config.file_path)
          match = matcher.above_line(config.line, regexp: regexp)[1]
          [single_file_command(config), '--filter', "'/\\b#{match}\\b/'"].join(' ')
        end

        def script_for(_config)
          return './vendor/bin/phpunit' if File.exist?('vendor/bin/phpunit')

          'phpunit'
        end
      end
    end
  end
end
