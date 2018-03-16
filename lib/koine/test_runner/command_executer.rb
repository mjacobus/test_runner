module Koine
  class TestRunner
    class CommandExecuter
      def execute(command)
        system(command.to_s)
        $CHILD_STATUS.exitstatus
      end

      def execute_and_exit(command)
        puts command
        exit(execute(command))
      end
    end
  end
end
