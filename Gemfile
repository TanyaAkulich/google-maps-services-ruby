source 'https://rubygems.org'

# Specify your gem's dependencies in google_maps_service.gemspec
gemspec

group :development do
  gem 'bundler'
  gem 'rake'
  gem 'rspec'
  gem 'simplecov'
  gem 'coveralls'
  gem 'webmock'
end

platforms :ruby do
  group :development do
    gem 'yard'
    gem 'redcarpet'
  end
end

if ENV['RAILS_VERSION']
  gem 'rails', ENV['RAILS_VERSION']
end
