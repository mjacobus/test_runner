require 'fileutils'
require 'logger'

require 'koine/test_runner/version'
require 'koine/test_runner/command_executer'
require 'koine/test_runner/configuration'
require 'koine/test_runner/builder'
require 'koine/test_runner/adapters'
require 'koine/test_runner/adapters/base_adapter'
require 'koine/test_runner/adapters/base_regexp'
require 'koine/test_runner/adapters/custom'
require 'koine/test_runner/adapters/null'
require 'koine/test_runner/adapters/last_command'

module Koine
  class TestRunner
    autoload :FileMatcher, 'koine/test_runner/file_matcher'

    class Adapters
      autoload :Minitest, 'koine/test_runner/adapters/minitest'
      autoload :Rspec, 'koine/test_runner/adapters/rspec'
      autoload :Phpunit, 'koine/test_runner/adapters/phpunit'
    end

    def initialize(adapters = [])
      @adapters = Adapters.new(adapters)
    end

    def run(configuration)
      test_command = @adapters.test_command(configuration)
      executer = CommandExecuter.new

      if test_command
        return executer.execute_and_exit(test_command)
      end

      executer.fail('No tests run')
    end
  end
end
