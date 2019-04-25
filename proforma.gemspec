# frozen_string_literal: true

require './lib/proforma/version'

Gem::Specification.new do |s|
  s.name        = 'proforma'
  s.version     = Proforma::VERSION
  s.summary     = 'Configurable and extendable document rendering engine for datasets'

  s.description = <<-DESCRIPTION
    Provide a simple, configurable, and standardized document generation object model.
    The basic premise is to pass in a dataset and configuration and this library will return rendered documents.
    The rendering engines can be plugged in so it leaves this as an extendable/open framework.
  DESCRIPTION

  s.authors     = ['Matthew Ruggio']
  s.email       = ['mruggio@bluemarblepayroll.com']
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.homepage    = 'https://github.com/bluemarblepayroll/proforma'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.3.8'

  s.add_dependency('acts_as_hashable', '~>1')

  s.add_development_dependency('guard-rspec', '~>4.7')
  s.add_development_dependency('pry', '~>0')
  s.add_development_dependency('rspec', '~> 3.8')
  s.add_development_dependency('rubocop', '~>0.63.1')
  s.add_development_dependency('simplecov', '~>0.16.1')
  s.add_development_dependency('simplecov-console', '~>0.4.2')
end
