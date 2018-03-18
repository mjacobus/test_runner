module Koine
  class TestRunner
    class FileMatcher
      NoMatchError = Class.new(RuntimeError)

      def initialize(file_path:)
        @lines = File.readlines(file_path)
      end

      def above_line(line, regexp:)
        length = @lines.length
        slice = length - line
        lines = @lines.reverse.slice(slice, length)
        lines.each do |file_line|
          match = regexp.match(file_line)
          return match if match
        end

        raise NoMatchError
      end
    end
  end
end
