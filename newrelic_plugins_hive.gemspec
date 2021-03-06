# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'newrelic_plugins_hive/version'

Gem::Specification.new do |spec|
  spec.name        = 'newrelic_plugins_hive'
  spec.version     = NewRelicPluginsHive::VERSION
  spec.authors     = ['Elad Maimon']
  spec.email       = ['elad.maimon@klarna.com']
  spec.description = %q{This agent consolidates and manages multiple New Relic plugins. It pulls the agents that defined in .yml file and run them all in one process.}
  spec.summary     = %q{One process agent for multiple New Relic plugins}
  spec.date        = '2013-12-15'
  spec.homepage    = 'https://github.com/elad-maimon/newrelic_plugins_hive'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   << 'hive'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'newrelic_plugin'
  spec.add_runtime_dependency 'daemons'
  spec.add_runtime_dependency 'slop'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'coveralls'
end
