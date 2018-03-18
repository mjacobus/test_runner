require 'spec_helper'

RSpec.describe Koine::TestRunner::FileMatcher do
  let(:file) { 'spec/fixtures/FixturePhpUnitTest.php' }
  subject { described_class.new(file_path: file) }

  [
    [9, 'testShouldAddTwoNumbers'],
    [10, 'testShouldAddTwoNumbers'],
    [11, 'testShouldAddTwoNumbers'],
    [12, 'testShouldAddTwoNumbers'],
    [38, 'aTestMarkedWithTestAnnotation'],
    [39, 'aTestMarkedWithTestAnnotation'],
    [40, 'aTestMarkedWithTestAnnotation'],
    [41, 'aTestMarkedWithTestAnnotation']
  ].each do |element|
    line = element.first
    expected_match = element.last

    specify "#above_line with #{line}, returns #{expected_match}" do
      regexp = /public function ([^\(]+)/

      match = subject.above_line(line, regexp: regexp)

      expect(match[1]).to eq(expected_match)
    end
  end

  specify '#matche_above raise error when there is no match' do
    expect do
      subject.above_line(2, regexp: /fooooo/)
    end.to raise_error(Koine::TestRunner::FileMatcher::NoMatchError)
  end
end
