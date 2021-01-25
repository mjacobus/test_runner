# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::TestRunner::Builder do
  describe '#build' do
    let(:adapter_config) do
      {
        'file_pattern' => 'client/.*.spec.js',
        'commands' => { 'all' => 'bar' }
      }
    end

    let(:file_config) do
      {
        'adapters' => {
          'some' => { 'adapter' => adapter_name }.merge(adapter_config)
        }
      }
    end

    let(:mock_config) { allow(YAML).to receive(:load_file).and_return(file_config) }

    let(:config) { Koine::TestRunner::Configuration.new(['file']) }

    let(:runner) do
      described_class.new(config).build
    end

    it 'builds the runner based on the config file' do
      adapters = [
        Koine::TestRunner::Adapters::Rspec.new(
          file_pattern: '.*_spec.rb$'
        ),
        Koine::TestRunner::Adapters::Phpunit.new(
          file_pattern: '.*Test.php$'
        )
      ]

      expected_runner = Koine::TestRunner.new(adapters)

      expect(runner).to be_equal_to(expected_runner)
    end

    describe 'with snake_case_adapters' do
      let(:adapter_name) { 'custom_adapter' }

      before { mock_config }

      it 'creates a config based on snake_case_adapter_names' do
        expect { runner }.to raise_error(
          'Cannot locate adapter custom_adapter => Koine::TestRunner::Adapters::CustomAdapter'
        )
      end
    end

    describe 'custom addapter' do
      let(:adapter_name) { 'custom' }

      before { mock_config }

      it 'creates a config based on snake_case_adapter_names' do
        adapters = [
          Koine::TestRunner::Adapters::Custom.new(
            file_pattern: 'client/.*.spec.js',
            commands: { 'all' => 'bar' }
          )
        ]

        expected_runner = Koine::TestRunner.new(adapters)

        expect(runner).to be_equal_to(expected_runner)
      end
    end

    it 'builds the runner based on the config file' do
      adapters = [
        Koine::TestRunner::Adapters::Rspec.new(
          file_pattern: '.*_spec.rb$'
        ),
        Koine::TestRunner::Adapters::Phpunit.new(
          file_pattern: '.*Test.php$'
        )
      ]

      expected_runner = Koine::TestRunner.new(adapters)

      expect(runner).to be_equal_to(expected_runner)
    end
  end
end
