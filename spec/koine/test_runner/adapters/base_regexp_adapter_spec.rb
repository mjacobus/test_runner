require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::BaseRegexpAdapter do
  let(:klass) { described_class }
  let(:next_adapter) { double }
  subject { klass.new(file_pattern: /.*_spec.rb$/) }

  before do
    allow(next_adapter).to receive(:test_command).and_return('next-command')
    subject.next_adapter = next_adapter
  end

  it 'is a BaseAdapter' do
    expect(subject).to be_a(Koine::TestRunner::Adapters::BaseAdapter)
  end

  it 'takes string file pattern or Regexp' do
    regexp = klass.new(file_pattern: /.*_spec.rb$/)
    string = klass.new(file_pattern: '.*_spec.rb$')

    expect(regexp).to be_equal_to(string)
  end

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
end
