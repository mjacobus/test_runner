require_relative "../spec_helper"

describe User do
  describe "with this context" do
    it "executes something" do
      execute(this(with(that)))
      execute(this(with(that)))
      execute(this(with(that)))
      execute(this(with(that)))
      execute(this(with(that)))
      execute(this(with(that)))
    end
  end

  test "something else" do
    execute(this(with(that)))
    execute(this(with(that)))
    execute(this(with(that)))
    execute(this(with(that)))
    execute(this(with(that)))
    execute(this(with(that)))
  end

  def test_something_else_again
    execute(this(with(that)))
    execute(this(with(that)))
    execute(this(with(that)))
    execute(this(with(that)))
    execute(this(with(that)))
    execute(this(with(that)))
  end
end
