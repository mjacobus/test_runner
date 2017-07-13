require 'yaml'

module Koine
  class TestRunner
    class Builder
      def initialize(arguments)
        initialize_from_yaml_config(arguments.config_file)
      end

      def build
        TestRunner.new(@adapters)
      end

      private

      def initialize_from_yaml_config(config_file)
        config = YAML.load_file(config_file)

        @adapters = config['adapters'].map do |adapter_config|
          build_adapter(adapter_config.last)
        end
      end

      def build_adapter(config)
        adapter = config.delete('adapter')

        if adapter.downcase == adapter.to_s
          adapter_class = "Koine::TestRunner::Adapters::#{adapter.capitalize}"
        end

        unless Object.const_defined?(adapter_class)
          raise ArgumentError, "Cannot locate adapter #{adapter} => #{adapter_class}"
        end

        klass = Object.const_get(adapter_class)
        klass.new(symbolize_keys(config))
      end

      def symbolize_keys(hash)
        {}.tap do |new_hash|
          hash.each do |key, value|
            new_hash[key.to_sym] = value
          end
        end
      end
    end
  end
end
