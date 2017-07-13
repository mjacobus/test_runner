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
        @options[:line].to_s.strip != ''
      end

      def config_file
        return @options[:config_file] if @options[:config_file]
        return '.test_runner.yml' if File.exist?('.test_runner.yml')
        File.expand_path('../../../../config/default.yml', __FILE__)
      end

      def run_options
        { file_path: file_path, line: line }
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

        data.each do |values|
          key = values.first
          value = values.length == 2 ? values.last : nil
          @options[normalize_key(key)] = value
        end
      end

      def normalize_key(key)
        key.tr('-', '_').to_sym
      end
    end
  end
end
