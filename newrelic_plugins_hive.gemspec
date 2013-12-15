# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'newrelic_plugins_hive/version'

Gem::Specification.new do |spec|
  spec.name        = 'newrelic_plugins_hive'
  spec.version     = NewrelicPluginsHive::VERSION
  spec.authors     = ['Elad Maimon']
  spec.email       = ['elad.maimon@klarna.com']
  spec.description = %q{This agent consolidates and manages multiple New Relic plugins. It pulls the agents that defined in .yml file and run them all in one process.}
  spec.summary     = %q{One process agent for multiple New Relic plugins}
  spec.date        = '2013-12-15'
  spec.homepage    = 'https://github.com/elad-maimon/newrelic_plugins_hive'
  spec.license     = 'MIT'

  spec.files       = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
