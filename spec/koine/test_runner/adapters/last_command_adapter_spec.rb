require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::LastCommandAdapter do
  let(:config) { Factory.config(['file']) }
  let(:next_adapter) { MockAdapter.new(accept: false, command: 'cmd1') }
  let(:storage) { double(:storage) }
  let(:command) { subject.test_command(config) }
  let(:last_command) { nil }

  subject { described_class.new(storage: storage) }

  before do
    allow(storage).to receive(:retrieve).and_return(last_command)
    subject.next_adapter = next_adapter
  end

  context 'when next returns something' do
    before do
      next_adapter.accept = true
      allow(storage).to receive(:store).with('cmd1')
    end

    it 'returns that something' do
      expect(command).to eq 'cmd1'
    end

    it 'stores that something' do
      command

      expect(storage).to have_received(:store).with(command)
    end
  end

  context 'when next does not return a thing' do
    context 'when there is something in the storage' do
      let(:last_command) { 'the-last-stored-command' }

      it 'returns that something' do
        expect(command).to eq last_command
      end
    end

    context 'when there is nothing in the storage' do
      let(:last_command) { nil }

      it 'returns that something' do
        command = subject.test_command(config)

        expect(command).to be_nil
      end
    end
  end

  describe 'storage' do
    before do
      FileUtils.rm_rf('.cache')
    end

    let(:file_storage) { Koine::TestRunner::Adapters::LastCommandAdapter::Storage.new }

    describe '#retrieve' do
      it 'returns nil when file does not exist' do
        expect(file_storage.retrieve).to be_nil
      end
    end

    it 'stores value' do
      file_storage.store('one')
      expect(file_storage.retrieve).to eq('one')

      file_storage.store('two')
      expect(file_storage.retrieve).to eq('two')
    end
  end
end
