class MockAdapter < Koine::TestRunner::Adapters::BaseAdapter
  attr_accessor :accept, :command
  attr_reader :configs

  def initialize(accept:, command:)
    @configs = []
    @accept = accept
    @command = command
  end

  def accept?(config)
    configs.push(config)
    accept
  end

  def next_adapter
    @next_adapter || null_adapter
  end

  def null_adapter
    Koine::TestRunner::Adapters::NullAdapter.new
  end

  private

  def single_file_command(_config)
    command
  end
end

class MockFallbackAdapter < Koine::TestRunner::Adapters::BaseAdapter
  def test_command(config)
    command = next_adapter.test_command(config)

    unless command
      return 'fallback'
    end

    command
  end
end
