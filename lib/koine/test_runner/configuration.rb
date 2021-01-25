# frozen_string_literal: true

module Koine
  class TestRunner
    class Configuration
      attr_reader :file_path

      def initialize(attributes = [])
        initialize_options(attributes.dup)
        initialize_attributes(attributes.dup)
      end

      def line
        @options[:line].to_i if line?
      end

      def line?
        @options[:line].to_s.tr('true', '').strip != ''
      end

      def all?
        @options[:all]
      end

      def last?
        @options[:last]
      end

      def config_file
        return @options[:config_file] if @options[:config_file]
        return '.test_runner.yml' if File.exist?('.test_runner.yml')

        File.expand_path('../../../config/default.yml', __dir__)
      end

      def run_options
        { file_path: file_path, line: line }
      end

      private

      def initialize_attributes(arguments)
        @file_path = arguments.reject { |arg| arg =~ /^--/ }.shift

        if require_file_name? && @file_path.nil?
          raise ArgumentError, 'file name was not given'
        end
      end

      def require_file_name?
        !last?
      end

      def initialize_options(data)
        @options = { all: false }

        data = data.select { |arg| arg =~ /^--([a-z-]+)/ }.map do |arg|
          arg.split('--').last.split('=')
        end

        data.each do |values|
          key = values.first
          value = values.length == 2 ? values.last : true
          @options[normalize_key(key)] = value
        end
      end

      def normalize_key(key)
        key.tr('-', '_').to_sym
      end
    end
  end
end
