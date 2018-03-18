module Koine
  class TestRunner
    class Adapters
      class Custom < BaseRegexp
        def initialize(file_pattern:, command: nil, commands: {})
          super(file_pattern: file_pattern)
          @command = command
          @commands = {}.tap do |hash|
            commands.each do |key, value|
              hash[key.to_sym] = value
            end
          end
        end

        private

        def all_tests(config)
          command(command_for(:all), config)
        end

        def single_file_command(config)
          command(command_for(:file), config)
        end

        def file_line_command(config)
          command(command_for(:line), config)
        end

        def command_for(type)
          @commands.fetch(type).to_s
        end

        def command(template, config)
          template.sub('{command}', @command)
                  .sub('{file}', config.file_path.to_s)
                  .sub('{line}', config.line.to_s)
        end
      end
    end
  end
end
