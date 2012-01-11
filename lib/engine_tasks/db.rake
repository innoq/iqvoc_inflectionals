# encoding: UTF-8

namespace :iqvoc_inflectionals do
  namespace :db do

    desc "Migrate the database through scripts in db/migrate and update db/schema.rb by invoking db:schema:dump. Target specific version with VERSION=x. Turn off output with VERBOSE=false."
    task :migrate => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate(Iqvoc::Inflectionals::Engine.find_root_with_flag("db").join('db/migrate'), ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end

    desc "Load seeds (task is idempotent)"
    task :seed => :environment do
      Iqvoc::Inflectionals::Engine.load_seed
    end

  end
end
