source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in historical_validate.gemspec
gemspec

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'ammeter'
end

group :test do
  gem 'devise', '~> 4.0'
  gem 'activerecord', '~> 5.1.0'
end

group :develop do
  gem 'rubocop'
end
