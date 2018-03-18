lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'koine/test_runner'

Gem::Specification.new do |spec|
  spec.name          = 'koine-test_runner'
  spec.version       = TestRunner::VERSION
  spec.authors       = ['Marcelo Jacobus']
  spec.email         = ['marcelo.jacobus@gmail.com']

  spec.summary       = 'Easy test runner'
  spec.description   = 'Easy test runner'
  spec.homepage      = 'https://github.com/mjacobus/test_runner'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'coveralls', '~> 0.8.21'
  spec.add_development_dependency 'object_comparator', '~> 0.1.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.53.0'
  spec.add_development_dependency 'simplecov', '~> 0.14.1'
end
