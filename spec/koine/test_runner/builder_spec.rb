require 'spec_helper'

RSpec.describe Koine::TestRunner::Builder do
  describe '#build' do
    let(:config) { Koine::TestRunner::Arguments.new(['file']) }

    let(:runner) do
      described_class.new(config).build
    end

    it 'builds the runner based on the config file' do
      adapters = [
        Koine::TestRunner::Adapters::Rspec.new(
          file_pattern: '.*_spec.rb$'
        )
      ]

      expected_runner = Koine::TestRunner.new(adapters)

      expect(runner).to be_equal_to(expected_runner)
    end
  end
end
