require 'spec_helper'

RSpec.describe Koine::TestRunner::Arguments do
  let(:file) do
    'spec/koine/test_runner/arguments_spec.rb'
  end

  let(:arguments) { create(file) }

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

  describe '#config_file' do
    before do
      allow(File).to receive(:exist?).with('.test_runner.yml') { false }
    end

    it 'defaults to config/default.yml' do
      config = File.expand_path('../../../../config/default.yml', __FILE__)

      expect(arguments.config_file).to eq(config)
    end

    it 'returns .test_runner.yml when this file exists' do
      allow(File).to receive(:exist?).with('.test_runner.yml') { true }

      expect(arguments.config_file).to eq('.test_runner.yml')
    end

    it 'return custom file when given' do
      arguments = create(file, '--config-file=/var/config/config.yml')

      expect(arguments.config_file).to eq('/var/config/config.yml')
    end
  end

  def create(*args)
    described_class.new(args)
  end
end
