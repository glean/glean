# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','glean','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'glean'
  s.version = Glean::VERSION
  s.author = 'John Britton'
  s.email = 'public@johndbritton.com'
  s.homepage = 'http://github.com/glean/glean'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split($/)
  s.require_paths << 'lib'
  s.rdoc_options << '--title' << 'glean' << '--main' << 'README.rdoc'
  s.bindir = 'bin'
  s.executables << 'glean'
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('rb-fsevent')
  s.add_development_dependency('rspec-nc')
  s.add_development_dependency('pry')
  s.add_development_dependency('webmock', '~> 1.8.0')
  s.add_development_dependency('vcr')
  s.add_runtime_dependency('gli','~> 2.5')
  s.add_runtime_dependency('git','~> 1.2')
  s.add_runtime_dependency('toml', '~> 0.0.3')
  s.add_runtime_dependency('octokit', '~> 2.0')
  s.add_runtime_dependency('hashie', '~> 2.0')
  s.add_runtime_dependency('json', '~> 1.7')
  s.add_runtime_dependency('highline', '~> 1.6')
  s.add_runtime_dependency('sysinfo', '~> 0.8')
end
