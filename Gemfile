source 'https://rubygems.org'

gem 'iqvoc', '~> 4.13', :github => 'innoq/iqvoc', branch: 'rails-6'
gem 'iqvoc_skosxl', '~> 2.10.0', :github => 'innoq/iqvoc_skosxl', branch: 'rails-6'

group :development do
  gem 'better_errors'
  gem 'web-console'
  gem 'listen'
end

group :development, :test do
  gem 'pry-rails', require: 'pry'

  platforms :ruby do
    gem 'pg'
    #gem 'mysql2'
    #gem 'sqlite3'
  end
  platforms :jruby do
    gem 'activerecord-jdbcpostgresql-adapter'
    #gem 'activerecord-jdbcmysql-adapter'
    #gem 'activerecord-jdbcsqlite3-adapter'
  end
end
