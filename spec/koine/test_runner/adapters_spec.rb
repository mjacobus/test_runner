require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters do
  let(:config) { Koine::TestRunner::Configuration.new(['file']) }
  let(:adapter1) { instance_double(Koine::TestRunner::Adapters::Rspec) }
  let(:adapter2) { instance_double(Koine::TestRunner::Adapters::Rspec) }
  let(:adapter3) { instance_double(Koine::TestRunner::Adapters::Rspec) }

  subject do
    described_class.new([adapter1, adapter2, adapter3])
  end

  before do
    allow(adapter1).to receive(:accept?).with(config) { false }
    allow(adapter2).to receive(:accept?).with(config) { true }
    allow(adapter3).to receive(:accept?).with(config) { false }

    allow(adapter1).to receive(:test_command).with(config) { 'command_1' }
    allow(adapter2).to receive(:test_command).with(config) { 'command_2' }
    allow(adapter3).to receive(:test_command).with(config) { 'command_3' }
  end

  describe '#test_command' do
    it 'gets command from the first adapter that accepts the config' do
      command = subject.test_command(config)

      expect(command).to eq('command_2')
    end

    it 'raises when there is no adapter for it' do
      subject = described_class.new([adapter1])

      expect do
        subject.test_command(config)
      end.to raise_error(ArgumentError, "Unknown runner for 'file'")
    end
  end
end
