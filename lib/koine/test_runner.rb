require "koine/test_runner/version"
require "koine/test_runner/arguments"

module Koine
  class TestRunner
    def run(file_path:, line: nil)
      some_line_not_executed

      if foo
        some_line_not_executed
      end

      some_line_not_executed
      some_line_not_executed
      some_line_not_executed
      some_line_not_executed
    end
  end
end
