Gem::Specification.new do |spec|
  spec.name          = 'commons-checker'
  spec.version       = '0.1'
  spec.authors       = ['Louise Crow', 'Mark Longair']
  spec.email         = ['parliaments@mysociety.org']

  spec.summary       = 'Checker scripts for Democratic Commons repos'
  spec.homepage      = 'https://github.com/everypolitician/commons-checker'
  spec.license       = 'MIT'

  spec.required_ruby_version = '~> 2.4.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables = ['check']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'webmock', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'codecov'
  spec.add_dependency 'dbf', '~> 3.0.0'
  spec.add_dependency 'json'
end
