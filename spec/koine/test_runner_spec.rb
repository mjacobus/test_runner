require "spec_helper"

RSpec.describe TestRunner do
  it "has a version number" do
    expect(TestRunner::VERSION).not_to be nil
  end
end
