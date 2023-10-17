source 'https://rubygems.org'

gem 'iqvoc', '~> 4.14.2', :github => 'innoq/iqvoc', branch: 'master'
gem 'iqvoc_skosxl', '~> 2.11.2', :github => 'innoq/iqvoc_skosxl', branch: 'master'

group :development do
  gem 'better_errors'
  gem 'web-console'
  gem 'listen'
end

group :development, :test do
  gem 'pry-rails', require: 'pry'

  platforms :ruby do
    gem 'pg'
  end
  platforms :jruby do
    gem 'activerecord-jdbcpostgresql-adapter'
  end
end
