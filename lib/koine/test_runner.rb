require 'koine/test_runner/version'
require 'koine/test_runner/configuration'
require 'koine/test_runner/builder'
require 'koine/test_runner/adapters'

module Koine
  class TestRunner
    class Adapters
      autoload :Rspec, 'koine/test_runner/adapters/rspec'
    end

    def initialize(adapters = [])
      @adapters = Adapters.new(adapters)
    end

    def run(configuration)
      p configuration.file_path
    end
  end
end
