if ENV['SKIP_COVERAGE'] == 'true'
  puts "Skipping coverage"
else
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]
  )

  SimpleCov.start do
    add_filter './spec/'
  end
end

require 'bundler/setup'
require 'koine/test_runner'
require 'object_comparator/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
