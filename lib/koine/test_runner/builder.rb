module Koine
  class TestRunner
    class Builder
      def initialize(arguments)
        p arguments.config_file
      end

      def build
        TestRunner.new
      end
    end
  end
end
