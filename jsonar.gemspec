require File.expand_path('../lib/jsonar/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'jsonar'
  s.version     = Jsonar::VERSION
  s.executables << 'jsonar'
  s.date        = '2017-10-10'
  s.summary     = 'Jsonar is a command line searching tool for JSON files'
  s.description = 'Jsonar is a command line searching tool for JSON files'
  s.authors     = ['Shioju']
  s.email       = 'shioju12@gmail.com'
  s.files       = ['lib/jsonar.rb', 'lib/jsonar/version.rb', 'lib/jsonar/cli.rb', 'lib/jsonar/indexer.rb']
  s.homepage    = 'http://rubygems.org/gems/jsonar'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.6'
end
