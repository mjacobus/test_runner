require 'spec_helper'

RSpec.describe Koine::TestRunner::Builder do
  describe '#build' do
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
      let(:file_config) do
        {
          'adapters' => {
            'some' => {
              'adapter' => 'custom_adapter',
              'file_pattern' => 'client/.*.spec.js',
              'commands' => { 'all' => 'bar' }
            }
          }
        }
      end

      before do
        allow(YAML).to receive(:load_file).and_return(file_config)
      end

      it 'creates a config based on snake_case_adapter_names' do
        adapters = [
          Koine::TestRunner::Adapters::CustomAdapter.new(
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
