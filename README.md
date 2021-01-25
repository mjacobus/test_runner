# TestRunner

Easy test runner customization

[![Build Status](https://travis-ci.com/mjacobus/test_runner.svg?branch=master)](https://travis-ci.com/mjacobus/test_runner)
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
  rspec:
    adapter: rspec
    file_pattern: "*_spec.rb"

  phpunit:
    adapter: phpunit
    file_pattern: "*Test.php"

  jest:
    adapter: custom
    file_pattern: "client/.*.spec.js"
    command: "./node_modules/.bin/jest"
    commands:
      all: "{command}"
      file: "{command} {file}"
      # oops, jest does not really filter by line
      line: "{command} {file}"

  # TODO
  My::CustoAdapter:
    require:
      - some/file
    adapter: MyCustomAdapter
    suffix: '_spec.custom'
```

```ruby
module My
  class CustomAdapter
    def initialize(suffix:)
      @suffix = suffix
    end

    # return nil if you do not want to deal with it
    def test_command(config)
      if config.file_path.end_with?(@suffix)
        return "./bin/test #{config.file_path}"
      end
    end
  end
end
```

Now you can run:

```bash
bundle exec run_test some/file_spec.custom
```

## Running the last test

Either run a file that does not get caught by any adapter

```bash
bundle exec run_test some/file_spec.unkown # run last test
```

Or

```bash
bundle exec run_test --last
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjacobus/test_runner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

