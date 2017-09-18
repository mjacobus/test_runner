require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::Rspec do
  let(:klass) { described_class }
  subject { klass.new }

  describe '#accept?' do
    [
      'foo/bar/baz_spec.rb',
      'foo/foo_spec.rb',
      'foo_spec.rb'
    ].each do |file|
      it "accept #{file}" do
        config = Koine::TestRunner::Configuration.new([file])
        expect(subject.accept?(config)).to be true
      end
    end

    [
      'foo/bar/spec_helper.rb',
      'foo/spec.rb',
      'spec.rb'
    ].each do |file|
      it "rejects #{file}" do
        config = Koine::TestRunner::Configuration.new([file])
        expect(subject.accept?(config)).to be false
      end
    end
  end

  describe '#script_for' do
    it 'defaults to bundle exec rspec' do
      allow(File).to receive(:exist?).with('bin/rspec').and_return(false)

      expect(subject.send(:script_for, double(:config))).to eq('bundle exec rspec')
    end

    context 'when ./bin/rspec exists' do
      it 'returns ./bin/rspec' do
        allow(File).to receive(:exist?).with('bin/rspec').and_return(true)

        expect(subject.send(:script_for, double(:config))).to eq('./bin/rspec')
      end
    end
  end

  describe '#test_command' do
    before do
      allow(File).to receive(:exist?).with('bin/rspec').and_return(false)
    end

    let(:file) { 'foo/bar_spec.rb' }

    it 'returns the correct test command for all files' do
      configuration = Koine::TestRunner::Configuration.new([file, '--all'])

      expect(subject.test_command(configuration)).to eq('bundle exec rspec')
    end

    it 'returns the correct test command for single file with line' do
      configuration = Koine::TestRunner::Configuration.new([file, '--line=5'])

      expect(subject.test_command(configuration)).to eq("bundle exec rspec #{file}:5")
    end

    it 'returns the correct test command for intire single file' do
      configuration = Koine::TestRunner::Configuration.new([file])

      expect(subject.test_command(configuration)).to eq("bundle exec rspec #{file}")
    end
  end
end
