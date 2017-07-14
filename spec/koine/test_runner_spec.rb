require 'spec_helper'

RSpec.describe Koine::TestRunner do
  it 'has a version number' do
    expect(TestRunner::VERSION).not_to be nil
  end

  it 'can be instantiated' do
    subject
  end
end
