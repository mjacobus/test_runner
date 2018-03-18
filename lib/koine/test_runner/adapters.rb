module Koine
  class TestRunner
    class Adapters
      def initialize(adapters = [], fallback: LastCommand.new)
        adapters = adapters.dup

        adapters.unshift(fallback)
        adapters.push(Adapters::Null.new)

        adapters.inject do |previous, adapter|
          previous.next_adapter = adapter
          adapter
        end

        @chain = adapters.first
      end

      def test_command(config)
        @chain.test_command(config)
      end
    end
  end
end
