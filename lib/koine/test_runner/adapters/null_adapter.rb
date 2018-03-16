module Koine
  class TestRunner
    class Adapters
      class NullAdapter
        def accept?(_config)
          true
        end

        def test_command(_config)
          nil
        end
      end
    end
  end
end
