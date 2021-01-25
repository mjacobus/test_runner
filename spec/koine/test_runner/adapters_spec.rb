# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters do
  let(:config) { Koine::TestRunner::Configuration.new(['file']) }
  let(:fallback) { MockFallbackAdapter.new }
  let(:adapter1) { MockAdapter.new(accept: false, command: 'cmd1') }
  let(:adapter2) { MockAdapter.new(accept: false, command: 'cmd2') }
  let(:adapter3) { MockAdapter.new(accept: false, command: 'cmd3') }

  let(:adapters) { described_class.new([adapter1, adapter2, adapter3], fallback: fallback) }
  let(:null_adapter) { Koine::TestRunner::Adapters::Null.new }

  it 'chains the adapters correctly' do
    adapters

    expect(fallback.next_adapter).to be(adapter1)
    expect(adapter1.next_adapter).to be(adapter2)
    expect(adapter2.next_adapter).to be(adapter3)
    expect(adapter3.next_adapter).to be_equal_to(null_adapter)
  end

  describe '#test_command' do
    it 'returns the fallback adapter response' do
      expect(adapters.test_command(config)).to eq 'fallback'
    end

    it 'returns the last adapter command when it accepts it' do
      adapter3.accept = true

      expect(adapters.test_command(config)).to eq('cmd3')
    end

    it 'returns the last adapter command when it accepts it' do
      adapter2.accept = true
      adapter3.accept = true

      expect(adapters.test_command(config)).to eq('cmd2')
    end
  end
end
