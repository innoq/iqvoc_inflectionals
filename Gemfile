source 'https://rubygems.org'

gem 'iqvoc', '~> 4.9.0', :github => 'innoq/iqvoc', branch: 'master'
gem 'iqvoc_skosxl', '~> 2.7.0', :github => 'innoq/iqvoc_skosxl', branch: 'master'

group :development, :test do
  gem 'spring'
  gem 'pry-rails'

  platforms :ruby do
    gem 'mysql2'
    gem 'sqlite3'
  end
  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
  end
end
