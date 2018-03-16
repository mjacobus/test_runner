require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::BaseAdapter do
  let(:klass) { described_class }
  let(:next_adapter) { double }
  let(:config) { Factory.config('file') }

  subject { klass.new }

  before do
    allow(next_adapter).to receive(:test_command).with(config).and_return('next-command')
    subject.next_adapter = next_adapter
  end

  describe '#next_adapter' do
    it 'returns the next adapter if exists' do
      expect(subject.next_adapter).to be(next_adapter)
    end

    it 'raises error' do
      subject.next_adapter = nil

      expect { subject.next_adapter }.to raise_error(
        'next_adapter is not set for Koine::TestRunner::Adapters::BaseAdapter'
      )
    end
  end

  describe '#test_command' do
    it 'returns nil the value of next adapter' do
      command = subject.test_command(config)

      expect(command).to eq('next-command')
    end
  end
end
