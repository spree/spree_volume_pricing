Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_volume_pricing'
  s.version     = '3.2.0'
  s.summary     = 'Allow prices to be configured in quantity ranges for each variant'
  s.description = 'Allow prices to be configured in quantity ranges for each variant'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Sean Schofield'
  s.email             = 'sean@railsdog.com'
  s.homepage          = 'http://spreecommerce.com'
  s.rubyforge_project = 'spree_volume_pricing'

  # s.files        = Dir['README.md', 'lib/**/*', 'app/**/*', 'config/*', 'db/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '~> 1.1.0')

  # test suite
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'capybara', '1.1.2'
  s.add_development_dependency 'factory_girl_rails', '~> 3.5.0'
  s.add_development_dependency 'rspec-rails',  '~> 2.11.0'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'sqlite3'
end
