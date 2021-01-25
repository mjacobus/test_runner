# frozen_string_literal: true

module Koine
  class TestRunner
    class CommandExecuter
      def execute(command)
        system(command.to_s)
        $CHILD_STATUS.exitstatus
      end

      def fail(reason)
        puts reason
        exit(1)
      end

      def execute_and_exit(command)
        puts command
        exit(execute(command))
      end
    end
  end
end
