# encoding: UTF-8

namespace :db do

  task :migrate_all => :environment do
    Iqvoc.invoke_engine_tasks "db:migrate", %w(iqvoc iqvoc_skosxl)
  end

  task :seed_all => :environment do
    Iqvoc.invoke_engine_tasks "db:seed", %w(iqvoc iqvoc_skosxl)
  end

end
