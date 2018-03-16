class Factory
  def self.config(*args)
    Koine::TestRunner::Configuration.new(args)
  end
end
