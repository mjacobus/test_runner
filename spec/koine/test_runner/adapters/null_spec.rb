# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::Null do
  describe '#test_command' do
    it 'does not care. Returns nil' do
      expect(subject.test_command(nil)).to be_nil
    end
  end
end
