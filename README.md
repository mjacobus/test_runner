# TestRunner

Easy test runner customization

[![Build Status](https://travis-ci.org/mjacobus/test_runner.svg?branch=master)](https://travis-ci.org/mjacobus/koine-test_runner)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/test_runner/badge.svg?branch=master)](https://coveralls.io/github/mjacobus/test_runner?branch=master)
[![Code Climate](https://codeclimate.com/github/mjacobus/test_runner/badges/gpa.svg)](https://codeclimate.com/github/mjacobus/test_runner)
[![Issue Count](https://codeclimate.com/github/mjacobus/test_runner/badges/issue_count.svg)](https://codeclimate.com/github/mjacobus/test_runner)

[![Gem Version](https://badge.fury.io/rb/koine-test_runner.svg)](https://badge.fury.io/rb/koine-test_runner)
[![Dependency Status](https://gemnasium.com/badges/github.com/mjacobus/test_runner.svg)](https://gemnasium.com/github.com/mjacobus/test_runner)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'koine-test_runner'
```

And then execute:

    $ bundle


## Usage

```bash
# run tested code in line 55
bundle exec run_test some/file_spec.rb --line=55

# run the whole file
bundle exec run_test some/file.php

# unknown file
bundle exec run_test some/file_spec.custom 
# => error: No test runner found for file 'some/file_spec.custom'
```

### File Customization

```yaml
# .test_runner.yml

adapters:
  minitest:
    adapter: Koine\TestRunner\Adapter\Ruby\Minitest
    file_pattern: "*_test.rb"

  rspec:
    adapter: Koine\TestRunner\Adapter\Ruby\RSpec
    file_pattern: "*_spec.rb"

  phpunit:
    adapter: Koine\TestRunner\Adapter\Php\PHPUnit
    file_pattern: "*Test.php"

  codeception:
    adapter: Koine\TestRunner\Adapter\Php\Codeception
    file_pattern: "*Spec.php"

  jest:
    adapter: Koine\TestRunner\Adapter\Javascript\Jest
    file_pattern: "*_(test|spec).(js|jsx)"

  My::CustoAdapter:
    adapter: MyCustomAdapter
    suffix: '_spec.custom'
```

```ruby
module My
  class CustomAdapter
    def initialize(suffix:)
      @suffix = suffix
    end

    def matches?(file_path)
      file_path.end_with?(@suffix)
    end

    def test_command_for_file(file_path: line: nil)
      cmd = ["/usr/bin/my_test --file=#{file_path}"]

      if line
        cmd << "--line=#{line}"
      end

      cmd.join(' ')
    end
  end
end
```

Now you can run:

```bash
bundle exec run_test some/file_spec.custom
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjacobus/test_runner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

