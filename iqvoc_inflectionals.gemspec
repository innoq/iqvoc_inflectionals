# encoding: UTF-8

$:.push File.expand_path("../lib", __FILE__)
require 'iqvoc/inflectionals/version'

Gem::Specification.new do |s|
  s.name        = 'iqvoc_inflectionals'
  s.version     = Iqvoc::Inflectionals::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Robert Glaser', 'Till Schulte-Coerne', 'Frederik Dohr']
  s.email       = ['robert.glaser@innoq.com']
  s.homepage    = '' # TODO
  s.summary     = '' # TODO
  s.description = '' # TODO

  s.rubyforge_project = 'iqvoc_inflectionals'

  s.add_dependency 'iqvoc', '~> 4.14.0'
  s.add_dependency 'iqvoc_skosxl', '~> 2.11.0'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
