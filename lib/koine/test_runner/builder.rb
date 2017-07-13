module Koine
  class TestRunner
    class Builder
      def initialize(arguments)
        p arguments.config_file
      end

      def build
        TestRunner.new(Adapters.new)
      end
    end
  end
end
