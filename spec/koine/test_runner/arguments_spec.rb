require 'spec_helper'

RSpec.describe Koine::TestRunner::Arguments do
  let(:file) do
    'spec/koine/test_runner/arguments_spec.rb'
  end

  describe '#initialize' do
    it 'throws when no file_path was given' do
      expect do
        create
      end.to raise_error(ArgumentError, 'file name was not given')
    end

    it 'throws when an argument was given but no file_path' do
      expect do
        create('--line=50')
      end.to raise_error(ArgumentError, 'file name was not given')
    end

    it 'sets file_path' do
      expect(create(file).file_path).to eq(file)
    end
  end

  describe '#line' do
    it 'is initially nil' do
      expect(create(file).line).to be_nil
    end

    it 'can be set to a number' do
      expect(create(file, '--line=10').line).to eq(10)
    end
  end

  def create(*args)
    described_class.new(args)
  end
end
