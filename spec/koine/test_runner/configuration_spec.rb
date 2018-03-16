require 'spec_helper'

RSpec.describe Koine::TestRunner::Configuration do
  let(:file) do
    'spec/koine/test_runner/arguments_spec.rb'
  end

  subject { create(file) }

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
      subject = create(file)

      expect(subject.file_path).to eq(file)
    end

    it 'allows --last only argument' do
      config = create('--last')

      expect(config.last?).to be true
    end
  end

  describe '#line' do
    it 'is initially nil' do
      expect(create(file).line).to be_nil
    end

    it 'can be set to a number' do
      subject = create(file, '--line=10')

      expect(subject.line).to eq(10)
    end

    it 'when no number is given it is nil' do
      subject = create(file, '--line=')

      expect(subject.line).to be_nil
    end
  end

  describe '#config_file' do
    before do
      allow(File).to receive(:exist?).with('.test_runner.yml') { false }
    end

    it 'defaults to config/default.yml' do
      config = File.expand_path('../../../../config/default.yml', __FILE__)

      expect(subject.config_file).to eq(config)
    end

    it 'returns .test_runner.yml when this file exists' do
      allow(File).to receive(:exist?).with('.test_runner.yml') { true }

      expect(subject.config_file).to eq('.test_runner.yml')
    end

    it 'return custom file when given' do
      subject = create(file, '--config-file=/var/config/config.yml')

      expect(subject.config_file).to eq('/var/config/config.yml')
    end
  end

  describe '#all_tests?' do
    it 'is initially false' do
      expect(subject.all?).to be false
    end

    it 'is initially false' do
      subject = create(file, '--all')

      expect(subject.all?).to be true
    end
  end

  def create(*args)
    Factory.config(*args)
  end
end
