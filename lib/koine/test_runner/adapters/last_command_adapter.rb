module Koine
  class TestRunner
    class Adapters
      class LastCommandAdapter < BaseAdapter
        def test_command(config)
          next_adapter.test_command(config)
        end
      end
    end
  end
end
