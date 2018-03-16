module Koine
  class TestRunner
    class Adapters
      class LastCommandAdapter < BaseAdapter
        def initialize(storage: Storage.new)
          @storage = storage
        end

        def test_command(config)
          command = next_adapter.test_command(config)

          unless command
            return @storage.retrieve
          end

          @storage.store(command)
          command
        end

        class Storage
          def initialize(file_path: '.cache/koine/last-test-command.cache')
            @file_path = file_path
          end

          def retrieve
            if File.exist?(@file_path)
              File.read(@file_path).strip
            end
          end

          def store(value)
            folder = File.dirname(@file_path)

            unless File.exist?(folder)
              FileUtils.mkdir_p(folder)
            end

            File.open(@file_path, 'w') { |f| f.puts(value) }
          end
        end
      end
    end
  end
end
