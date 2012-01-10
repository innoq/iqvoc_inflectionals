# encoding: UTF-8

namespace :db do

  task :migrate_all => :environment do
    engines = %w(iqvoc iqvoc_skosxl)
    tasks = engines.map { |engine| "#{engine}:db:migrate" }
    tasks << "db:migrate"
    tasks.each do |task|
      Rake::Task[task].invoke
    end
  end

  task :seed_all => :environment do
    Rake::Task["iqvoc:db:seed"].invoke
    Rake::Task["db:seed"].invoke
  end

end
