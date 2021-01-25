# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::TestRunner::Adapters::Custom do
  subject { MockAdapter.succeed(adapter) }

  let(:file) { 'foo/bar/baz/file_spec.rb' }

  let(:adapter) do
    described_class.new(
      file_pattern: /_spec.rb$/,
      command: './bin/rspec',
      commands: {
        all: '{command}',
        'file' => '{command} {file}',
        'line' => '{command} {file}:{line}'
      }
    )
  end

  it 'is a file pattern based adapter' do
    expect(subject).to be_a(Koine::TestRunner::Adapters::BaseRegexp)
  end

  it 'inores files that is none of it\'s concern' do
    config = Factory.config('some-other-file')

    expect(subject.test_command(config)).to be_nil
  end

  it 'returns the command for all files' do
    config = Factory.config(file, '--all')

    command = subject.test_command(config)

    expect(command).to eq('./bin/rspec')
  end

  it 'returns the command for single file' do
    config = Factory.config(file)

    command = subject.test_command(config)

    expect(command).to eq("./bin/rspec #{file}")
  end

  it 'returns the command for single file filtered by line' do
    config = Factory.config(file, '--line=10')

    command = subject.test_command(config)

    expect(command).to eq("./bin/rspec #{file}:10")
  end
end
