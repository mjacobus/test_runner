require 'spec_helper'

RSpec.describe Koine::TestRunner do
  let(:config) { Factory.config(['file']) }

  it 'has a version number' do
    expect(TestRunner::VERSION).not_to be nil
  end

  it 'can be instantiated' do
    subject
  end

  it 'exits with error when no command is executed' do
    allow_any_instance_of(Koine::TestRunner::Adapters)
      .to receive(:test_command).with(config).and_return(nil)

    expect_any_instance_of(Koine::TestRunner::CommandExecuter)
      .to receive(:fail).with('No tests run')

    subject.run(config)
  end

  it 'exits with error when no command is executed' do
    allow_any_instance_of(Koine::TestRunner::Adapters)
      .to receive(:test_command).with(config).and_return('some command')

    expect_any_instance_of(Koine::TestRunner::CommandExecuter)
      .to receive(:execute_and_exit).with('some command')

    subject.run(config)
  end
end
