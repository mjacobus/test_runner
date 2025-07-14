require_relative './base_regexp'

module Koine
  class TestRunner
    class Adapters
      class Minitest < BaseRegexp
        def initialize(file_pattern: /.*_test.rb$/)
          super(file_pattern: file_pattern)
        end

        private

        def script_for(_config)
          return './bin/rails' if File.exist?('bin/rails')

          'ruby'
        end

        def file_line_command(config)
          [
            single_file_command(config),
            regexp(line: config.line, file: config.file_path),
          ].join(' -n ')
        end

        def regexp(line:, file:)
          text = extract_text_from_file(file:, line:)
          "\"/#{text}/\""
        end

        def extract_text_from_file(file:, line:)
          lines = File.read(file).split("\n")[0, line].reverse

          lines.each do |line_content|
            match = match_text(line_content)
            if match
              return match
            end
          end
        end

        def match_text(line_content)
          if line_content =~ /it\s+"(.+?)"/ || line_content =~ /test\s+"(.+?)"/
            return Regexp.last_match(1)
          end

          if line_content =~ /def\s+test_(.+)/
            return Regexp.last_match(1)
          end
        end
      end
    end
  end
end
