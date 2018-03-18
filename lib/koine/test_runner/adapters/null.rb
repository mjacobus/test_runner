module Koine
  class TestRunner
    class Adapters
      class Null
        def test_command(_config)
          nil
        end
      end
    end
  end
end
