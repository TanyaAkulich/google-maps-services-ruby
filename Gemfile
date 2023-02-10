source 'https://rubygems.org'

# Specify your gem's dependencies in google_maps_service.gemspec
gemspec

group :development do
  gem 'bundler', '~> 2.4', '>= 2.4.6'
  gem 'rake', '~> 13.0', '>= 13.0.6'
  gem 'rspec', '~> 3.12'
  gem 'simplecov', '~> 0.16.1'
  gem 'coveralls', '~> 0.8.22'
  gem 'webmock', '~> 3.18', '>= 3.18.1'
end

platforms :ruby do
  group :development do
    gem 'yard', '~> 0.9.28'
    gem 'redcarpet', '~> 3.6'
  end
end

if ENV['RAILS_VERSION']
  gem 'rails', ENV['RAILS_VERSION']
end
