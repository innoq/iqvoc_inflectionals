source 'https://rubygems.org'

gem 'iqvoc', '~> 4.12', :github => 'innoq/iqvoc', branch: 'master'
gem 'iqvoc_skosxl', '~> 2.9.0', :github => 'innoq/iqvoc_skosxl', branch: 'master'

group :development, :test do
  gem 'pry-rails', require: 'pry'

  platforms :ruby do
    gem 'mysql2'
    gem 'pg', '~> 0.21'
    gem 'sqlite3'
  end
  platforms :jruby do
    gem 'activerecord-jdbcmysql-adapter'
    gem 'activerecord-jdbcpostgresql-adapter'
    gem 'activerecord-jdbcsqlite3-adapter'
  end
end
