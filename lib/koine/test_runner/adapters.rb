module Koine
  class TestRunner
    class Adapters
      def initialize(adapters = [])
        @adapters = adapters
      end

      def test_command(config)
        @adapters.each do |adapter|
          if adapter.accept?(config)
            return adapter.test_command(config)
          end
        end

        raise ArgumentError, "Unknown runner for '#{config.file_path}'"
      end
    end
  end
end
