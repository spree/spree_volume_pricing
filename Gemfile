source 'http://rubygems.org'

group :test do
  gem 'rspec-rails', '~> 2.9.0'
  gem 'factory_girl', '~> 2.6.4'
  gem 'factory_girl_rails', '~> 1.7'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'guard-rspec'

  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'rb-fsevent'
    gem 'growl'
  end
end

gem 'spree', '~> 1.1.3'

gemspec