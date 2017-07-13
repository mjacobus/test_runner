module Koine
  class TestRunner
    class Arguments
      attr_reader :file_path

      def initialize(attributes = [])
        initialize_attributes(attributes.dup)
        initialize_options(attributes.dup)
      end

      def line
        @options[:line].to_i if line?
      end

      def line?
        @options.key?(:line)
      end

      private

      def initialize_attributes(arguments)
        @file_path = arguments.reject { |arg| arg =~ /=/ }.shift
        raise ArgumentError, 'file name was not given' unless @file_path
      end

      def initialize_options(data)
        @options = {}

        data = data.select { |arg| arg =~ /^--([a-z-]+)=/ }.map do |arg|
          arg.split('--').last.split('=')
        end

        data.each do |value|
          @options[value.first.to_sym] = value.last
        end
      end
    end
  end
end
