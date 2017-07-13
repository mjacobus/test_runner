require "koine/test_runner/version"
require "koine/test_runner/arguments"
require "koine/test_runner/builder"
require "koine/test_runner/adapters"
require "koine/test_runner/adapters/rspec"

module Koine
  class TestRunner
    def initialize(adapters = [])
      @adapters = Adapters.new(adapters)
    end

    def run(file_path:, line: nil)
      p file_path
    end
  end
end
