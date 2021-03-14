module Koine
  class TestRunner
    class CommandExecuter
      def execute(command)
        start = Time.now
        system(command.to_s)
        finish = Time.now
        elapsed = finish - start
        logger.info("#{command} => elapsed time: #{elapsed.round(2)}")
        puts "\nTook #{elapsed.round(2)} seconds"
        $?.exitstatus
      end

      def fail(reason)
        puts reason
        exit(1)
      end

      def execute_and_exit(command)
        puts command
        exit(execute(command))
      end

      def logger
        @logger ||= Logger.new('/tmp/test_runner.log')
      end
    end
  end
end
