require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::Rspec do
  let(:klass) { described_class }
  subject { klass.new }

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
