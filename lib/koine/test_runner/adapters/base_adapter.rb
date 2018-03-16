module Koine
  class TestRunner
    class Adapters
      class BaseAdapter
        # attr_writer :next_adapter

        def next_adapter=(adapter)
          @next_adapter = adapter
        end

        def next_adapter
          @next_adapter || raise("next_adapter is not set for #{self.class}")
        end

        def test_command(config)
          unless accept?(config)
            return next_adapter.test_command(config)
          end

          if config.all?
            return all_tests(config)
          end

          if config.line?
            return file_line_command(config)
          end

          single_file_command(config)
        end

        private

        def accept?(_config)
          false
        end

        def all_tests(config)
          script_for(config)
        end

        def file_line_command(config)
          [single_file_command(config), config.line].join(':')
        end

        def single_file_command(config)
          [script_for(config), config.file_path].join(' ')
        end

        def script_for(_config)
          raise 'Not implemented'
        end
      end
    end
  end
end
