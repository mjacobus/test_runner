require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::Minitest do
  subject(:adapter) { described_class.new }

  describe '#accept?' do
    [
      'foo/bar/baz_test.rb',
      'foo/foo_test.rb',
      'foo_test.rb'
    ].each do |file|
      it "accept #{file}" do
        config = Koine::TestRunner::Configuration.new([file])
        expect(adapter.send(:accept?, config)).to be true
      end
    end

    [
      'foo/bar/test_helper.rb',
      'foo/test.rb',
      'test.rb'
    ].each do |file|
      it "rejects #{file}" do
        config = Koine::TestRunner::Configuration.new([file])
        expect(adapter.send(:accept?, config)).to be false
      end
    end
  end

  describe '#script_for' do
    it 'defaults to bundle exec ruby' do
      allow(File).to receive(:exist?).with('bin/rails').and_return(false)

      expect(adapter.send(:script_for, double(:config))).to eq('ruby')
    end

    context 'when ./bin/rails exists' do
      it 'returns ./bin/rails' do
        allow(File).to receive(:exist?).with('bin/rails').and_return(true)

        expect(adapter.send(:script_for, double(:config))).to eq('./bin/rails')
      end
    end
  end

  describe '#test_command' do
    before do
      allow(File).to receive(:exist?).with('bin/rails').and_return(false)
    end

    let(:file) { 'spec/fixtures/minitest_fixture_test.rb' }

    it 'returns the correct test command for all files' do
      configuration = Koine::TestRunner::Configuration.new([file, '--all'])

      expect(adapter.test_command(configuration)).to eq('ruby')
    end

    it 'handles it block' do
      configuration = Koine::TestRunner::Configuration.new([file, '--line=7'])

      expect(adapter.test_command(configuration)).to eq("ruby #{file} -n \"/executes something/\"")
    end

    it 'handles it block with exact line' do
      configuration = Koine::TestRunner::Configuration.new([file, '--line=5'])

      expect(adapter.test_command(configuration)).to eq("ruby #{file} -n \"/executes something/\"")
    end

    it 'handles test block' do
      configuration = Koine::TestRunner::Configuration.new([file, '--line=18'])

      expect(adapter.test_command(configuration)).to eq("ruby #{file} -n \"/something else/\"")
    end

    it 'handles def methods' do
      configuration = Koine::TestRunner::Configuration.new([file, '--line=28'])

      expect(adapter.test_command(configuration)).to eq("ruby #{file} -n \"/something_else_again/\"")
    end
  end
end

