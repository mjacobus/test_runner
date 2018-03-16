module Koine
  class TestRunner
    class Adapters
      class NullAdapter
        def test_command(_config)
          nil
        end
      end
    end
  end
end
