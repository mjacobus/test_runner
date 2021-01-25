# frozen_string_literal: true

class Factory
  def self.config(*args)
    Koine::TestRunner::Configuration.new(args)
  end
end
