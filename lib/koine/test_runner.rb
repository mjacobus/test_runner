require 'koine/test_runner/version'
require 'koine/test_runner/command_executer'
require 'koine/test_runner/configuration'
require 'koine/test_runner/builder'
require 'koine/test_runner/adapters'

module Koine
  class TestRunner
    class Adapters
      autoload :BaseRegexpAdapter, 'koine/test_runner/adapters/base_regexp_adapter'
      autoload :Rspec, 'koine/test_runner/adapters/rspec'
    end

    def initialize(adapters = [])
      @adapters = Adapters.new(adapters)
    end

    def run(configuration)
      test_command = @adapters.test_command(configuration)
      CommandExecuter.new.execute_and_exit(test_command)
    end
  end
end
